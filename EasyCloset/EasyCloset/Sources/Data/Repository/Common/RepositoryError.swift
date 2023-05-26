//
//  RepositoryError.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

enum RepositoryError: LocalizedError {
  case invalidImage
  case invalidData
  case transferError(error: Error)
  case failToSave
  
  var errorDescription: String? {
    switch self {
    case .invalidImage:
      return "이미지가 올바르지 않습니다."
    case .invalidData:
      return "데이터가 잘못되었습니다."
    case .transferError(let error):
      return "에러가 발생했습니다. \(error)"
    case .failToSave:
      return "저장에 실패했습니다."
    }
  }
}
