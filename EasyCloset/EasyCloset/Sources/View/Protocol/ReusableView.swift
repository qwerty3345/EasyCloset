//
//  ReusableView.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

protocol ReusableView {
  static var reuseIdentifier: String { get }
}

extension ReusableView {
  static var reuseIdentifier: String {
    String(describing: self)
  }
}
