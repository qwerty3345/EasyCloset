//
//  ClothesEntity.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation
import RealmSwift

final class ClothesEntity: Object {
  @Persisted(primaryKey: true) var id: String
  @Persisted var createdAt: Date
  @Persisted var category: Int
  @Persisted var weatherType: Int
  @Persisted var descriptions: String
  
  convenience init(id: String,
                   createdAt: Date,
                   category: Int,
                   weatherType: Int,
                   descriptions: String) {
    self.init()
    self.id = id
    self.createdAt = createdAt
    self.category = category
    self.weatherType = weatherType
    self.descriptions = descriptions
  }
}

// MARK: - Model Mapping
extension ClothesEntity {
  func toModelWithoutImage() -> Clothes {
    Clothes(id: UUID(uuidString: id) ?? UUID(),
            createdAt: createdAt,
            image: nil,
            category: ClothesCategory(rawValue: category) ?? .top,
            weatherType: WeatherType(rawValue: weatherType) ?? .allWeather,
            descriptions: descriptions)
  }
}
