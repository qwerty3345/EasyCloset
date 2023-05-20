//
//  CarouselCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import Combine

protocol ClothesCarouselCellDelegate: AnyObject {
  func clothesCarouselCell(_ cell: ClothesCarouselCell, showClothesDetail clothes: Clothes)
  func clothesCarouselCell(_ cell: ClothesCarouselCell, addClothesOf categoty: ClothesCategory)
}

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
    static let collectionViewHeight: CGFloat = 180
    static let cellSize = CGSize(width: collectionViewHeight - 20,
                                 height: collectionViewHeight - 20)
  }
  
  // MARK: - Properties
  
  weak var delegate: ClothesCarouselCellDelegate?
  private lazy var dataSource: DataSource = makeDataSource()
  private var cancellables = Set<AnyCancellable>()
  
  private var category: ClothesCategory?
  
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
    self.category = category
    
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
    collectionView.backgroundColor = .clear
  }
  
  private func setupLayout() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: ClothesCell.self)
    collectionView.registerCell(cellClass: AddClothesCell.self)
    collectionView.delegate = self
  }
  
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
  
}

// MARK: - UICollectionViewDelegate

extension ClothesCarouselCell: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath),
          let category = category else { return }
    
    // 셀 아이템의 종류가 옷 추가였는지, 옷 상세정보 였는지를 판별해 delegate에 위임
    switch item {
    case .addClothes:
      delegate?.clothesCarouselCell(self, addClothesOf: category)
    case .clothes(let clothes):
      delegate?.clothesCarouselCell(self, showClothesDetail: clothes)
    }

    // 자연스럽게 보이도록 0.5초 후에 해당 위치로 scroll
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
