//
//  FilterCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/24.
//

import UIKit

final class FilterCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
  let filterLabel = UILabel().then {
    $0.textAlignment = .center
    $0.font = .pretendardContent
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
    filterLabel.text = ""
  }
  
  // MARK: - Corner Radius
  // 레이아웃이 변경될 때 마다 모서리를 둥글게 처리해주도록 함
  
  private var oldFrame: CGRect = .zero
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    guard oldFrame != frame else { return }
    configureCornerRadius()
    oldFrame = frame
  }
  
  private func configureCornerRadius() {
    layer.cornerRadius = frame.height / 2
  }
}

// MARK: - UI & Layout

extension FilterCell {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    layer.borderColor = UIColor.seperator.cgColor
    layer.borderWidth = 1
  }
  
  private func setupLayout() {
    addSubview(filterLabel)
    filterLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
