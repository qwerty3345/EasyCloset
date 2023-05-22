//
//  StyleCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

import SnapKit

final class StyleCell: UICollectionViewCell, Highlightable {
  
  // MARK: - UI Components
  
  private let infoView = InfoView(with: "", fontSize: .pretendardSmallTitle)
  
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
  
  func configure(with style: Style) {
    infoView.configure(title: style.name ?? "")
    infoView.configure(with: style.collageImage)
  }
  
  // MARK: - Private Methods
  
  private func resetUIComponents() {
    infoView.configure(with: nil)
    infoView.configure(title: "")
  }
}

// MARK: - UI & Layout

extension StyleCell {
  
  private func setup() {
    setupLayout()
    setUI()
  }
  
  private func setUI() {
    backgroundColor = .systemBackground
    addShadowToCell(to: .bottom)
  }
  
  private func setupLayout() {
    addSubview(infoView)
    infoView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StyleCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      return StyleCell()
    }
    .frame(width: 200, height: 200)
    .border(.black, width: 1)
    .previewLayout(.sizeThatFits)
  }
}
#endif
