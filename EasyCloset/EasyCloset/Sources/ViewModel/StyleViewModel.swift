//
//  StyleViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation

import Combine

final class StyleViewModel {
  @Published private(set) var styles = [Style]()
  
  // 3초 후에 로딩 되는 것을 테스트 함
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
      self.styles = Style.mocks
    }
  }
}
