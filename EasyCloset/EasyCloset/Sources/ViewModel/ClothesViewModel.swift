//
//  ClothesViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

final class ClothesViewModel {
  @Published private(set) var clothesList = ClothesList.mock
  
  func clothes(of category: ClothesCategory) -> [Clothes] {
    return clothesList.clothesByCategory[category] ?? []
  }
  
}
