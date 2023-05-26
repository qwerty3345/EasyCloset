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

final class StyleAddClothesController: UIViewController {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding: CGFloat = 20
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Clothes>
  
  enum Section: Int, CaseIterable {
    case main
  }
  
  // MARK: - Properties
  
  private let viewModel = ClothesViewModel()
  
  private let category: ClothesCategory
  
  private lazy var dataSource: DataSource = makeDataSource()
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: collectionViewFlowLayout)
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout().then {
    let itemWidth = view.frame.width / 2 - (Metric.padding) - 10
    $0.itemSize = .init(width: itemWidth, height: itemWidth)
    $0.minimumInteritemSpacing = Metric.padding / 2
  }
  
  private lazy var selectBarButton = UIBarButtonItem(
    title: "선택",
    style: .plain,
    target: self,
    action: #selector(tappedSelectButton))
  
  // MARK: - Initialization
  
  init(category: ClothesCategory) {
    self.category = category
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
    navigationItem.rightBarButtonItem = selectBarButton
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: StyleDetailCell.self)
    collectionView.dataSource = dataSource
    collectionView.contentInset = UIEdgeInsets(top: 0, left: Metric.padding,
                                               bottom: 0, right: Metric.padding)
  }
}

// MARK: - DataSource

extension StyleAddClothesController {
  
  private func makeDataSource() -> DataSource {
    return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: StyleDetailCell.self, for: indexPath)
      
      return cell
    }
  }
  
  private func applySnapshot(with clothesList: [Clothes]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Clothes>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(clothesList, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct StyleAddClothesControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = StyleAddClothesController(category: .bottom)
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
