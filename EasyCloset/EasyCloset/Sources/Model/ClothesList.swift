//
//  ClothesList.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

struct ClothesList {
  let clothesByCategory: [ClothesCategory: [Clothes]]
  
  static var mock: ClothesList {
    ClothesList(
      clothesByCategory:
        [
          .top: [Clothes.mock, Clothes.mock, Clothes.mock, Clothes.mock],
          .bottom: [],
          .accessory: [Clothes.mock, Clothes.mock, Clothes.mock, Clothes.mock],
          .outer: [Clothes.mock, Clothes.mock, Clothes.mock, Clothes.mock],
          .shoes: [Clothes.mock, Clothes.mock, Clothes.mock, Clothes.mock]
        ]
    )
  }
}
