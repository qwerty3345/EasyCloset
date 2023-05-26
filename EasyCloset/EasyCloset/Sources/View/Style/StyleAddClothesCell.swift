//
//  StyleAddClothesCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import UIKit

import SnapKit

final class StyleAddClothesCell: UICollectionViewCell, Highlightable {
  
  // MARK: - UI Components
  
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
  
  func configure(with item: StyleAddClothesController.Item) {
    switch item {
    case .remove:
      clothesImageView.image = UIImage(systemName: "nosign")
    case .clothes(let clothes):
      clothesImageView.image = clothes.image
    }
  }
  
  func configure(with clothes: Clothes) {
    clothesImageView.image = clothes.image
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
    clothesImageView.image = .hangerPlus
  }
}

// MARK: - UI & Layout

extension StyleAddClothesCell {
  
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
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StyleAddClothesCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = StyleAddClothesCell()
      cell.configure(with: .mock)
      return cell
    }
    .frame(width: 200, height: 200)
    .border(.black, width: 1)
    .previewLayout(.sizeThatFits)
  }
}
#endif
