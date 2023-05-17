//
//  ClothesCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

final class ClothesCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
  private let clothesImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .lightGray
  }
  
  private let nameLabel = UILabel().then {
    $0.text = "#티셔츠"
    $0.font = .pretendard()
    $0.textColor = .lightGray
  }
  
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
  
  // MARK: - Lifecycle
  
  override func prepareForReuse() {
    super.prepareForReuse()
    resetUIComponents()
  }
  
  // MARK: - Public Methods
  
  func configure(with clothes: Clothes) {
    nameLabel.text = clothes.name
    // TODO: 이미지 넣기...
    clothes.imageURL
  }
  
  func showAddPhotoImage() {
    addSubview(addPhotoImageView)
    addPhotoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
    nameLabel.text = ""
    addPhotoImageView.isHidden = true
    clothesImageView.image = nil
  }
  
}

// MARK: - UI & Layout

extension ClothesCell {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    layer.cornerRadius = 8
    backgroundColor = .green
  }
  
  private func setupLayout() {
    addSubview(clothesImageView)
    clothesImageView.snp.makeConstraints {
      $0.width.height.equalToSuperview().multipliedBy(0.5)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().multipliedBy(0.8)
    }
    
    addSubview(nameLabel)
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(clothesImageView.snp.bottom)
      $0.bottom.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(16)
    }
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ClothesCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let clothesCell = ClothesCell()
      clothesCell.configure(with: .mock)
      return clothesCell
    }
    .frame(width: 150, height: 150)
    .previewLayout(.sizeThatFits)
  }
}
#endif
