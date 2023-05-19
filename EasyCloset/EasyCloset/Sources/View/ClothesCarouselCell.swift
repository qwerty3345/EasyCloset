//
//  CarouselCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import Combine

final class ClothesCarouselCell: UICollectionViewCell {
  
  enum Section: CaseIterable {
    case main
  }
  
  enum Item: Hashable {
    case addClothes
    case clothes(Clothes)
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
  
  // MARK: - Constants
  
  private enum Metric {
    static let collectionViewHeight: CGFloat = 160
    static let cellSize = CGSize(width: collectionViewHeight - 10,
                                 height: collectionViewHeight - 10)
  }
  
  // MARK: - Properties
  
  private lazy var dataSource: DataSource = makeDataSource()
  private var clothes: [Clothes] = []
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: carouselLayout
  )
  
  private let carouselLayout = CarouselFlowLayout().then {
    $0.itemSize = Metric.cellSize
    $0.scrollDirection = .horizontal
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Methods
  
  func bind(to viewModel: ClothesViewModel, with category: ClothesCategory) {
    viewModel.clothes(of: category)
      .sink { [weak self] clothes in
        guard let self = self else { return }
        self.applySnapshot(with: clothes)
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Private Methods
  
  private func applySnapshot(with clothes: [Clothes]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    
    let items = clothes.map { Item.clothes($0) }
    snapshot.appendItems([.addClothes] + items, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UI & Layout

extension ClothesCarouselCell {
  
  private func setup() {
    setUI()
    setupLayout()
    setupCollectionView()
  }
  
  private func setUI() {
  }
  
  private func setupLayout() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: ClothesCell.self)
    collectionView.registerCell(cellClass: AddPhotoCell.self)
  }
  
  private func makeDataSource() -> DataSource {
    DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case .addClothes:
        return collectionView.dequeueReusableCell(cellClass: AddPhotoCell.self, for: indexPath)
      case .clothes(let clothes):
        let cell = collectionView.dequeueReusableCell(cellClass: ClothesCell.self, for: indexPath)
        cell.configure(with: clothes)
        return cell
      }
    }
  }
  
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CarouselCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = ClothesCarouselCell()
      return cell
    }
    .frame(height: 180)
    .previewLayout(.sizeThatFits)
  }
}
#endif
