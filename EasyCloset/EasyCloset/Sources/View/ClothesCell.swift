//
//  ClothesCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

final class ClothesCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
//  private let containerView = UIView()
//    .then {
//    $0.backgroundColor = .lightGray
//  }
  
  private let clothesImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let nameLabel = UILabel().then {
    $0.text = "#티셔츠"
    $0.font = .pretendard()
    $0.textColor = .lightGray
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
    clothesImageView.image = clothes.image
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
    nameLabel.text = ""
    clothesImageView.image = nil
  }
  
}

// MARK: - UI & Layout

extension ClothesCell {
  
  private func setup() {
    setupLayout()
    setUI()
  }
  
  private func setUI() {
    backgroundColor = .systemBackground
//    shadowDecorate()

    addShadowToCell(to: .bottom)
    
//    contentView.layer.cornerRadius = 10
//    contentView.layer.borderWidth = 1
//    contentView.layer.borderColor = UIColor.clear.cgColor
//    contentView.layer.masksToBounds = true
//
//    layer.shadowColor = UIColor.black.cgColor
//    layer.shadowOffset = CGSize(width: 0, height: 1.0)
//    layer.shadowRadius = 10.0
//    layer.shadowOpacity = 0.1
//    layer.masksToBounds = false
//    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
//    layer.cornerRadius = 10
//
//    contentView.layer.masksToBounds = true
//    contentView.layer.cornerRadius = 8
//    contentView.layer.borderColor = UIColor.clear.cgColor
//    contentView.layer.borderWidth = 1
//    layer.backgroundColor = UIColor.clear.cgColor
//    addShadow(to: .bottom)
  }
  
  private func setupLayout() {
//    contentView.addSubview(containerView)
//    containerView.snp.makeConstraints {
//      $0.edges.equalToSuperview()
//    }
    
    contentView.addSubview(clothesImageView)
    clothesImageView.snp.makeConstraints {
      $0.width.height.equalToSuperview().multipliedBy(0.5)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().multipliedBy(0.8)
    }
    
    contentView.addSubview(nameLabel)
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
    .frame(width: 200, height: 200)
    .border(.black, width: 1)
    .previewLayout(.sizeThatFits)
  }
}
#endif
