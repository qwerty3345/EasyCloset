//
//  InfoView.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import UIKit

final class InfoView: UIControl {
  
  // MARK: - UI Components
  
  private let containerView = UIView().then {
    $0.layer.cornerRadius = 16
    $0.layer.masksToBounds = true
    $0.isUserInteractionEnabled = false
  }
  
  private let infoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let seperatorView = UIView().then {
    $0.backgroundColor = .seperator
  }
  
  private let infoLabel = UILabel()
  
  // MARK: - Initialization
  
  init(with title: String, image: UIImage? = nil, fontSize: UIFont? = .pretendardMediumTitle) {
    super.init(frame: .zero)
    setup()
    setupInfoLabel(with: title, fontSize: fontSize)
    configure(with: image)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Methods
  
  func configure(with image: UIImage?) {
    infoImageView.image = image
  }
}

// MARK: - UI & Layout

extension InfoView {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    backgroundColor = .white
    layer.cornerRadius = 16
    layer.masksToBounds = true
  }
  
  private func setupInfoLabel(with title: String, fontSize: UIFont?) {
    infoLabel.text = title
    infoLabel.font = fontSize
  }
  
  private func setupLayout() {
    addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    containerView.addSubview(infoImageView)
    infoImageView.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
    }
    
    containerView.addSubview(seperatorView)
    seperatorView.snp.makeConstraints {
      $0.height.equalTo(1)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalTo(infoImageView.snp.bottom)
    }
    
    containerView.addSubview(infoLabel)
    infoLabel.snp.makeConstraints {
      $0.top.equalTo(infoImageView.snp.bottom)
      $0.bottom.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.25)
      $0.horizontalEdges.equalToSuperview().inset(16)
    }
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct InfoViewPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      return InfoView(with: "옷장으로 이동")
    }
    .frame(height: 300)
    .border(.black, width: 1)
    .previewLayout(.sizeThatFits)
  }
}
#endif
