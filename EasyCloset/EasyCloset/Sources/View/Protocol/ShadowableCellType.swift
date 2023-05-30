//
//  ShadowableCellType.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import UIKit

protocol ShadowableCellType where Self: UIView {
  var contentView: UIView { get }
}
extension UICollectionViewCell: ShadowableCellType {}
extension UITableViewCell: ShadowableCellType {}

extension ShadowableCellType {
  func addShadowToCell(withCornerRadius radius: CGFloat = 10, to loation: ShadowLocation) {
    contentView.clipsToBounds = true
    
    layer.cornerRadius = radius
    addShadow(to: loation)
  }
}
