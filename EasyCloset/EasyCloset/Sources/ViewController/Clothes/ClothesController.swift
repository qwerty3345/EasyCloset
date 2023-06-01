//
//  ClothesController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import SnapKit
import Then

import Combine

final class ClothesController: UIViewController {
  
  // MARK: - Constants
  
  private enum Metric {
    static let collectionViewRowHeight: CGFloat = 180
  }
  
  enum Item: Hashable {
    case addClothes(ClothesCategory)
    case clothes(Clothes)
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<ClothesCategory, Item>
  
  // MARK: - Properties
  
  private let viewModel: ClothesViewModel
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: makeCollectionViewLayout())
  
  private lazy var dataSource: DataSource = makeDataSource()
  
  private lazy var refreshControl = UIRefreshControl().then {
    $0.addTarget(self, action: #selector(didTriggerRefresh), for: .valueChanged)
  }
  
  private lazy var filterButton = UIButton().then {
    $0.setImage(.filter, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.snp.makeConstraints { make in
      make.width.height.equalTo(24)
    }
    $0.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
  }
    
  // MARK: - Initialization
  
  init(viewModel: ClothesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.reloadData()
  }
  
  // MARK: - Private Methods
  
  // MARK: - Private Methods
  
  private func bind() {
    viewModel.filteredClothesList
      .sink { [weak self] clothesList in
        self?.applySnapshot(with: clothesList)
      }
      .store(in: &cancellables)
    
    viewModel.clothesListDidEndUpdate
      .sink { [weak refreshControl] in
        if refreshControl?.isRefreshing == true {
          refreshControl?.endRefreshing()
        }
      }
      .store(in: &cancellables)
  }
  
  @objc private func tappedFilterButton() {
    let filterController = ClothesFilterController(viewModel: viewModel)
    present(filterController, animated: true)
  }
  
  @objc func didTriggerRefresh() {
    viewModel.clothesListDidUpdate.send()
  }
}

// MARK: - UI & Layout

extension ClothesController {
  
  private func setup() {
    setUI()
    setupLayout()
    setupCollectionView()
  }
  
  private func setUI() {
    addLeftTitle(with: "MY CLOSET")
    setupFilterButton()
    view.backgroundColor = .background
    collectionView.backgroundColor = .clear
  }
  
  private func setupLayout() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }
  
  private func setupCollectionView() {
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    
    collectionView.registerCell(cellClass: ClothesCell.self)
    collectionView.registerCell(cellClass: AddClothesCell.self)
    collectionView.registerHeaderView(viewClass: ClothesCategoryHeaderView.self)
    
    configureHeaderViewprovider()
    
    collectionView.refreshControl = refreshControl
  }
  
  private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalWidth(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(160),
                                           heightDimension: .estimated(160))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
    
    setupHeader(to: section)
    setupCollectionViewCarousel(to: section)
    
    section.interGroupSpacing = 4
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  /// Carousel 을 적용하기 위해 셀 아이템에 중심부 부터의 거리를 계산 해 transform 을 적용
  private func setupCollectionViewCarousel(to section: NSCollectionLayoutSection) {
    section.visibleItemsInvalidationHandler = { visibleItems, offset, environment in
      
      // 헤더가 아닌 셀 아이템들
      let cellItems = visibleItems.filter {
        $0.representedElementKind != UICollectionView.elementKindSectionHeader
      }
      let containerWidth = environment.container.contentSize.width
      
      cellItems.forEach { item in
        let itemCenterRelativeToOffset = item.frame.midX - offset.x
        
        // 셀이 컬렉션 뷰의 중앙에서 얼마나 떨어져 있는지
        let distanceFromCenter = abs(itemCenterRelativeToOffset - containerWidth / 2.0)
        
        // 셀이 커지고 작아질 때의 최대 스케일, 최소 스케일
        let minScale: CGFloat = 0.7
        let maxScale: CGFloat = 1.0
        let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
        
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
      }
    }
  }
  
  private func setupHeader(to section: NSCollectionLayoutSection) {
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(100))
    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)
    
    section.boundarySupplementaryItems = [headerItem]
  }
  
  private func setupFilterButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
  }
}

// MARK: - DataSource / Snapshot

extension ClothesController {
  private func makeDataSource() -> DataSource {
    DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case .addClothes:
        return collectionView.dequeueReusableCell(cellClass: AddClothesCell.self, for: indexPath)
      case .clothes(let clothes):
        let cell = collectionView.dequeueReusableCell(cellClass: ClothesCell.self, for: indexPath)
        cell.configure(with: clothes)
        return cell
      }
    }
  }
  
  private func configureHeaderViewprovider() {
    dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
      let headerView = collectionView.dequeueReusableHeaderView(
        ofType: ClothesCategoryHeaderView.self,
        for: indexPath)
      
      if let category = ClothesCategory(rawValue: indexPath.section) {
        headerView.configure(with: category)
      }
      
      return headerView
    }
  }
  
  private func applySnapshot(with clothesList: ClothesList) {
    var snapshot = NSDiffableDataSourceSnapshot<ClothesCategory, Item>()
    snapshot.appendSections(ClothesCategory.allCases)
    
    ClothesCategory.allCases.forEach { category in
      let clothes = clothesList.clothesByCategory[category] ?? []
      let items = clothes.map { Item.clothes($0) }
      snapshot.appendItems([.addClothes(category)] + items, toSection: category)
    }
    
    print(snapshot.numberOfItems, snapshot)
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UICollectionViewDelegate

extension ClothesController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
   moveToSelectedItem(at: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView,
                      contextMenuConfigurationForItemAt indexPath: IndexPath,
                      point: CGPoint) -> UIContextMenuConfiguration? {
    return configureMenuConfiguration(of: indexPath)
  }
}

// MARK: - MenuConfigurable

extension ClothesController: MenuConfigurable {
  
  func moveToSelectedItem(at indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    
    HapticManager.fireImpact()
    
    // 셀 아이템의 종류가 옷 추가였는지, 옷 상세정보 였는지를 판별해 delegate에 위임
    switch item {
    case .addClothes:
      let detailController = DIContainer.shared.makeClothesDetailController(type: .add)
      detailController.delegate = self
      navigationController?.pushViewController(detailController, animated: true)
    case .clothes(let clothes):
      let detailController = DIContainer.shared.makeClothesDetailController(type: .showDetail(clothes: clothes))
      detailController.delegate = self
      navigationController?.pushViewController(detailController, animated: true)
    }
    
    // 자연스럽게 보이도록 0.5초 후에 해당 위치로 scroll
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  }
  
  func deleteSelectedItem(of indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath),
          case let .clothes(clothes) = item else { return }
    
    showAskAlert(title: "정말 삭제하시겠습니까?") { [weak self] isDelete in
      guard isDelete else { return }
      self?.viewModel.deleteClothes.send(clothes)
    }
  }
}

// MARK: - ClothesDetailControllerDelegate

extension ClothesController: ClothesDetailControllerDelegate {
  func clothesDetailController(didUpdateOrSave viewController: ClothesDetailController) {
    viewModel.clothesListDidUpdate.send()
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ClothesControllerPreview: PreviewProvider {
  static var previews: some View {
    UINavigationController(rootViewController: DIContainer.shared.makeClothesController()).toPreview()
  }
}
#endif
