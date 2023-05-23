//
//  ClothesViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

import Combine

final class ClothesViewModel {
  @Published private(set) var clothesList = ClothesList(clothesByCategory: [:])
  
  // 1초 후에 로딩 되는 것을 테스트 함
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      self.clothesList = .mock
    }
  }
  
  func clothes(of category: ClothesCategory) -> AnyPublisher<[Clothes], Never> {
    $clothesList
      .map {
        $0.clothesByCategory[category] ?? []
      }
      .eraseToAnyPublisher()
  }
  
}
