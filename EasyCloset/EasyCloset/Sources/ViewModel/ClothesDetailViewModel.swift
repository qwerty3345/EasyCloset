//
//  ClothesDetailViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation

import Combine

final class ClothesDetailViewModel {
  
  var clothes: CurrentValueSubject<Clothes, Never>
  
  init(clothes: Clothes) {
    self.clothes = CurrentValueSubject(clothes)
  }
  
  func save() {
    
  }
  
  func update() {
    
  }
}
