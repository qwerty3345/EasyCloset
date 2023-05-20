//
//  InfoView.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import UIKit

final class InfoView: UIView {
  
  // MARK: - UI Components
  
  private let containerView = UIView().then {
    $0.layer.cornerRadius = 16
    $0.layer.masksToBounds = true
  }
  
  private let infoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let seperatorView = UIView().then {
    $0.backgroundColor = .seperator
  }
  
  private let infoLabel = UILabel().then {
    $0.font = .pretendardMediumTitle
  }
  
  // MARK: - Initialization
  
  init(with title: String) {
    super.init(frame: .zero)
    setup()
    infoLabel.text = title
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Methods
  
  func set(image: UIImage?) {
    infoImageView.image = image
  }
  
  // MARK: - Private Methods
  
}

// MARK: - Layout

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
