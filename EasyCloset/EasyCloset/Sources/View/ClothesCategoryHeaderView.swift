//
//  CarouselClothesHeader.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import UIKit

final class ClothesCategoryHeaderView: UICollectionReusableView {
  
  // MARK: - UI Components
  
  private let categoryNameLabel = UILabel().then {
    $0.font = .pretendardLargeTitle
  }
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Methods
  
  func configure(with category: ClothesCategory) {
    categoryNameLabel.text = category.korean
  }
  
  // MARK: - Private Methods
  
  override func prepareForReuse() {
    super.prepareForReuse()
    categoryNameLabel.text = ""
  }
}

// MARK: - Layout

extension ClothesCategoryHeaderView {
  
  private func setupLayout() {
    addSubview(categoryNameLabel)
    categoryNameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.verticalEdges.equalToSuperview().inset(20)
    }
  }
}
