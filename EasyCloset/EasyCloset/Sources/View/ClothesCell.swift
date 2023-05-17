//
//  ClothesCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

final class ClothesCell: UICollectionViewCell {
  
  enum CellType {
    case add
    case show
  }
  
  // MARK: - Constants
  
  private enum Metric { }

  // MARK: - Properties
  
  // MARK: - UI Components
  
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
  
  func configure(with clothes: Clothes) {
    
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
  }
  
}

// MARK: - UI & Layout

extension ClothesCell {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    backgroundColor = .cyan
  }
  
  private func setupLayout() { }
}

