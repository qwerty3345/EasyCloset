//
//  UIView+Seperator.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

import SnapKit

extension UIView {
  static var seperatorView: UIView {
    let view = UIView()
    view.backgroundColor = .seperator
    view.snp.makeConstraints {
      $0.height.equalTo(1)
    }
    return view
  }
}
