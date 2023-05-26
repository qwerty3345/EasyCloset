//
//  StyleAddClothesController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/25.
//

import UIKit

import Then
import SnapKit

import Combine

protocol StyleAddClothesControllerDelegate: AnyObject {
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectClothes clothes: Clothes)
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectEmpty category: ClothesCategory)
}

final class StyleAddClothesController: UIViewController {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding: CGFloat = 20
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
  
  enum Section: Int, CaseIterable {
    case main
  }
  
  enum Item: Hashable {
    case remove
    case clothes(Clothes)
  }
  
  // MARK: - Properties
  
  private let viewModel: ClothesViewModel
  private var cancellables = Set<AnyCancellable>()
  
  private let category: ClothesCategory
  private lazy var dataSource: DataSource = makeDataSource()
  
  weak var delegate: StyleAddClothesControllerDelegate?
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: collectionViewFlowLayout)
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout().then {
    let itemWidth = view.frame.width / 2 - (Metric.padding) - 10
    $0.itemSize = .init(width: itemWidth, height: itemWidth)
    $0.minimumInteritemSpacing = Metric.padding / 2
  }
  
  private lazy var titleLabel = UILabel().then {
    $0.text = "스타일 \(category.korean) 선택"
    $0.font = .pretendardMediumTitle
    $0.textAlignment = .center
  }
  
  // MARK: - Initialization
  
  init(category: ClothesCategory,
       viewModel: ClothesViewModel) {
    self.category = category
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
  
  // MARK: - Private Methods
  
  private func bind() {
    viewModel.clothes(of: category)
      .sink { [weak self] clothesList in
        self?.applySnapshot(with: clothesList)
      }
      .store(in: &cancellables)
  }
  
  @objc private func tappedSelectButton() {
    
  }
}

// MARK: - UI & Layout

extension StyleAddClothesController {
  
  private func setup() {
    setUI()
    setupLayout()
    setupCollectionView()
  }
  
  private func setUI() {
    title = "옷 선택하기"
    view.backgroundColor = .background
    collectionView.backgroundColor = .background
  }
  
  private func setupLayout() {
    view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
      $0.height.equalTo(80)
    }
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: StyleAddClothesCell.self)
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(top: 0, left: Metric.padding,
                                               bottom: 0, right: Metric.padding)
  }
}

// MARK: - DataSource

extension StyleAddClothesController {
  
  private func makeDataSource() -> DataSource {
    return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: StyleAddClothesCell.self, for: indexPath)
      cell.configure(with: item)
      return cell
    }
  }
  
  private func applySnapshot(with clothesList: [Clothes]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    let clotheItems = clothesList.map { Item.clothes($0) }
    snapshot.appendItems([.remove] + clotheItems, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UICollectionViewDelegate

extension StyleAddClothesController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    switch item {
    case .remove:
      delegate?.styleAddClothesController(self, didSelectEmpty: category)
    case .clothes(let clothes):
      delegate?.styleAddClothesController(self, didSelectClothes: clothes)
    }
    dismiss(animated: true)
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct StyleAddClothesControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = DIContainer.shared.makeStyleAddClothesController(category: .bottom)
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
