//
//  ClothesList.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

struct ClothesList {
  var clothesByCategory: [ClothesCategory: [Clothes]]
}

// MARK: - Mock Data

extension ClothesList {
  static let mocks: ClothesList = {
    var clothesByCategory: [ClothesCategory: [Clothes]] = [:]
    clothesByCategory[.top] = [Clothes.Mock.top1, Clothes.Mock.top2, Clothes.Mock.top3]
    clothesByCategory[.bottom] = [Clothes.Mock.bottom1, Clothes.Mock.bottom2, Clothes.Mock.bottom3]
    clothesByCategory[.accessory] = [Clothes.Mock.accessory1, Clothes.Mock.accessory2]
    clothesByCategory[.outer] = [Clothes.Mock.outer1]
    clothesByCategory[.shoes] = [Clothes.Mock.shoes1]
    return ClothesList(clothesByCategory: clothesByCategory)
  }()
}
