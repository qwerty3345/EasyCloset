//
//  StyleDetailCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/25.
//

import UIKit

import SnapKit

final class StyleDetailCell: UICollectionViewCell, Highlightable {
  
  // MARK: - UI Components
  
  private let clothesLabel = UILabel().then {
    $0.font = .pretendardSmallTitle
    $0.textAlignment = .center
    $0.textColor = .white
    $0.backgroundColor = .seperator.withAlphaComponent(0.5)
  }
  
  private let clothesImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = .hangerPlus
  }
  
  // MARK: - Touch Events
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    highlight()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    unHighlight()
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
  
  func configure(category: ClothesCategory) {
    clothesLabel.text = category.korean
  }
  
  func configure(with clothes: Clothes) {
    clothesImageView.image = clothes.image
    clothesLabel.text = clothes.category.korean
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
    clothesImageView.image = .hangerPlus
    clothesLabel.text = ""
  }
}

// MARK: - UI & Layout

extension StyleDetailCell {
  
  private func setup() {
    setupLayout()
    setUI()
  }
  
  private func setUI() {
    backgroundColor = .systemBackground
    addShadowToCell(to: .bottom)
  }
  
  private func setupLayout() {
    addSubview(clothesImageView)
    clothesImageView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(10)
    }
    
    addSubview(clothesLabel)
    clothesLabel.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalToSuperview().inset(12)
      $0.height.equalTo(30)
    }
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StyleDetailCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = StyleDetailCell()
      cell.configure(category: .accessory)
      cell.configure(with: .mock)
      return cell
    }
    .frame(width: 200, height: 200)
    .border(.black, width: 1)
    .previewLayout(.sizeThatFits)
  }
}
#endif
