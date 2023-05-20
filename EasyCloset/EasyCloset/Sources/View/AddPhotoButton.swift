//
//  AddPhotoButton.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit
import SnapKit

final class AddPhotoButton: UIButton {
  
  // MARK: - Properties
  
  private let iconImageView = UIImageView().then {
    $0.tintColor = .white
    $0.contentMode = .scaleAspectFit
  }
  
  private let bottomLabel = UILabel().then {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.font = .pretendardMediumTitle
  }
  
  // MARK: - Initialization
  
  init(title: String, image: UIImage?, spacing: CGFloat = 10) {
    super.init(frame: .zero)
    
    iconImageView.image = image
    bottomLabel.text = title
    
    setupUI()
    setupLayout(spacing: spacing)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI & Layout
  
  private func setupUI() {
    layer.cornerRadius = 8
    backgroundColor = .black
  }
  
  private func setupLayout(spacing: CGFloat) {
    addSubview(iconImageView)
    iconImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(spacing)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.5)
      $0.height.equalTo(iconImageView.snp.width)
    }

    addSubview(bottomLabel)
    bottomLabel.snp.makeConstraints {
      $0.centerX.width.equalToSuperview()
      $0.top.equalTo(iconImageView.snp.bottom)
      $0.bottom.equalToSuperview().inset(spacing)
    }
  }
}
