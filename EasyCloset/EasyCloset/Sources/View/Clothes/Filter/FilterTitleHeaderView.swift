//
//  FilterTitleHeaderView.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/24.
//

import UIKit

final class FilterTitleHeaderView: UICollectionReusableView {
  
  // MARK: - UI Components
  
  private let seperatorView = UIView().then {
    $0.backgroundColor = .seperator
  }
  
  private let filterTitleLabel = UILabel().then {
    $0.font = .pretendardMediumTitle
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
  
  func configure(with section: ClothesFilterController.Section) {
    filterTitleLabel.text = section.description
  }
  
  // MARK: - Private Methods
  
  override func prepareForReuse() {
    super.prepareForReuse()
    filterTitleLabel.text = ""
  }
}

// MARK: - Layout

extension FilterTitleHeaderView {
  
  private func setupLayout() {
    addSubview(seperatorView)
    seperatorView.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    addSubview(filterTitleLabel)
    filterTitleLabel.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(10)
      $0.verticalEdges.equalToSuperview()
    }
  }
}
