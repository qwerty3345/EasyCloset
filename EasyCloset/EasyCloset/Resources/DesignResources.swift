//
//  DesignResources.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

extension UIColor {
  static let accentColor = UIColor(named: "AccentColor") ?? .systemBlue
}

extension UIImage {
  // TabBar
  static let closet = UIImage(named: "closet")
  static let closetSelected = UIImage(named: "closet-selected")
  static let house = UIImage(named: "home")
  static let houseSelected = UIImage(named: "home-selected")
  static let tshirt = UIImage(named: "tshirt")
  static let tshirtSelected = UIImage(named: "tshirt-selected")
  
  static let filter = UIImage(named: "filter")
}

extension UIFont {
  enum PretendardWeight: String {
    case black      = "Black"
    case extraBold  = "ExtraBold"
    case bold       = "Bold"
    case semiBold   = "SemiBold"
    case medium     = "Medium"
    case regular    = "Regular"
    case light      = "Light"
    case extraLight = "ExtraLight"
    case thin       = "Thin"
  }
  
  static func pretendard(size: CGFloat = 14,
                         weight: PretendardWeight = .regular) -> UIFont {
    return UIFont(name: "Pretendard-\(weight.rawValue)", size: size)!
  }
  
  static let pretendardLargeTitle = UIFont.pretendard(size: 18)
  static let pretendardMediumTitle = UIFont.pretendard(size: 16)
  static let pretendardContent = UIFont.pretendard(size: 12, weight: .light)
}
