//
//  CarouselCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

final class CarouselCell: UICollectionViewCell {
  
  // MARK: - Constants
  
  private enum Metric {
    static let collectionViewHeight: CGFloat = 160
    static let cellSize = CGSize(width: collectionViewHeight - 10,
                                 height: collectionViewHeight - 10)
  }
  
  // MARK: - Properties
  
  var category: ClothesCategory?
  
  private let mockClothes = (0..<10).map { _ in Clothes.mock }
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: carouselLayout
  ).then {
    $0.backgroundColor = .blue
    $0.dataSource = self
  }
  
  private lazy var carouselLayout = CarouselFlowLayout().then {
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
  
  // MARK: - Lifecycle
  
  override func prepareForReuse() {
    super.prepareForReuse()
    resetUIComponents()
  }
  
  // MARK: - Public Methods
  
  
  // MARK: - Private Methods
  

  private func resetUIComponents() {
  }
  
}

// MARK: - UI & Layout

extension CarouselCell {
  
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
  }
}

// MARK: - UICollectionViewDataSource

extension CarouselCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return mockClothes.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(cellClass: ClothesCell.self, for: indexPath)
    
    if let clothes = mockClothes[safe: indexPath.row] {
      cell.configure(with: clothes)
    }
    
    cell.backgroundColor = .cyan
    return cell
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CarouselCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = CarouselCell()
      return cell
    }
    .frame(height: 180)
    .previewLayout(.sizeThatFits)
  }
}
#endif
