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
  
  // Image
  static let addPhoto = UIImage(named: "add_photo")
  
  enum Sample {
    static let jacket1 = UIImage(named: "jacket1")
    static let pants1 = UIImage(named: "pants1")
    static let pants2 = UIImage(named: "pants2")
    static let pants3 = UIImage(named: "pants3")
    static let shortpants = UIImage(named: "shortpants")
    static let tshirt1 = UIImage(named: "tshirt1")
    static let tshirt2 = UIImage(named: "tshirt2")
    static let shirt1 = UIImage(named: "shirt1")
    static let shirt2 = UIImage(named: "shirt2")
    static let shoes1 = UIImage(named: "shoes1")
    static let cap1 = UIImage(named: "cap1")
    static let socks1 = UIImage(named: "socks1")
  }
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
                         weight: PretendardWeight = .regular) -> UIFont? {
    return UIFont(name: "Pretendard-\(weight.rawValue)", size: size)
  }
  
  static let pretendardLargeTitle = UIFont.pretendard(size: 18, weight: .semiBold)
  static let pretendardMediumTitle = UIFont.pretendard(size: 16)
  static let pretendardContent = UIFont.pretendard(size: 12, weight: .light)
}
