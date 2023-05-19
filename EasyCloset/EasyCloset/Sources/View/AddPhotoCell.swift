//
//  AddPhotoCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import UIKit

final class AddPhotoCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
  private let addPhotoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = .addPhoto
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI & Layout

extension AddPhotoCell {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    layer.cornerRadius = 8
  }
  
  private func setupLayout() {
    addSubview(addPhotoImageView)
    addPhotoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
