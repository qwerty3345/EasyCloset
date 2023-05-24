//
//  Clothes.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

struct Clothes: Hashable {
  let id: UUID
  let createdAt: Date
  var image: UIImage?
  var category: ClothesCategory
  var weatherType: WeatherType
  var descriptions: String
  
  init(id: UUID = UUID(),
       createdAt: Date = Date(),
       image: UIImage?,
       category: ClothesCategory,
       weatherType: WeatherType,
       descriptions: String) {
    self.id = id
    self.createdAt = createdAt
    self.image = image
    self.category = category
    self.weatherType = weatherType
    self.descriptions = descriptions
  }
}

// MARK: - Entity Mapping

extension Clothes {
  func toEntity() -> ClothesEntity {
    ClothesEntity(id: id.uuidString,
                  createdAt: createdAt,
                  category: category.rawValue,
                  weatherType: weatherType.rawValue,
                  descriptions: descriptions)
  }
}

// MARK: - Mock Data

extension Clothes {
  static var mock: Clothes {
    Clothes(
      image: .Sample.cap1 ?? UIImage(),
      category: .allCases.randomElement()!,
      weatherType: .allWeather,
      descriptions: "\(Int.random(in: (1...100)))"
    )
  }
}
