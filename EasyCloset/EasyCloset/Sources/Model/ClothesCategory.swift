//
//  ClothesCategory.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import Foundation

enum ClothesCategory: Int, CaseIterable {
  case outer
  case top
  case bottom
  case shoes
  case accessory
  
  var korean: String {
    switch self {
    case .top:
      return "상의"
    case .bottom:
      return "하의"
    case .outer:
      return "외투"
    case .shoes:
      return "신발"
    case .accessory:
      return "악세사리"
    }
  }
}
