//
//  SortBy.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/24.
//

import Foundation

enum SortBy: Int, CaseIterable {
  case new
  case old
  
  var korean: String {
    switch self {
    case .new:
      return "최신순"
    case .old:
      return "오래된순"
    }
  }
}
