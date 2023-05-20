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
  let imageURL: String
  var image: UIImage?
  var category: ClothesCategory
  var weatherType: WeatherType
  var description: String?
  
  init(id: UUID = UUID(),
       createdAt: Date = Date(),
       imageURL: String,
       image: UIImage? = nil,
       category: ClothesCategory,
       weatherType: WeatherType,
       description: String? = nil) {
    self.id = id
    self.createdAt = createdAt
    self.imageURL = imageURL
    self.image = image
    self.category = category
    self.weatherType = weatherType
    self.description = description
  }
  
  static var mock: Clothes {
    Clothes(
      imageURL: "",
      image: .Sample.cap1,
      category: .allCases.randomElement()!,
      weatherType: .allWeather,
      description: "\(Int.random(in: (1...100)))"
    )
  }
}
