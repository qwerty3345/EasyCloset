//
//  UIViewController+NavigationTitle.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

extension UIViewController {
  func addLeftTitle(with title: String) {
    let label = UILabel()
    label.text = title
    label.font = .pretendardLargeTitle
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
  }
}
