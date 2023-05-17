//
//  Resources.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

enum Color {
  static let accentColor = UIColor(named: "AccentColor") ?? .systemBlue
}

enum Icon {
  // TabBar
  static let closet = UIImage(named: "closet")
  static let closetSelected = UIImage(named: "closet-selected")
  static let house = UIImage(named: "home")
  static let houseSelected = UIImage(named: "home-selected")
  static let tshirt = UIImage(named: "tshirt")
  static let tshirtSelected = UIImage(named: "tshirt-selected")
  
  static let filter = UIImage(named: "filter")
}
