//
//  Highlightable.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

protocol Highlightable: UIView {
  func highlight()
  func unHighlight()
}

extension Highlightable {
  
  func highlight() {
    HapticManager.fireImpact()
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
      let highlightScale: CGFloat = 0.95
      self.transform = CGAffineTransform(scaleX: highlightScale, y: highlightScale)
    }
  }
  
  func unHighlight() {
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
      let unhighlightScale: CGFloat = 1.0
      self.transform = CGAffineTransform(scaleX: unhighlightScale, y: unhighlightScale)
    }
  }
}
