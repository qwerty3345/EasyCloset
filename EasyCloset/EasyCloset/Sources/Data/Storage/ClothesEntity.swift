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
  @Persisted var imageURL: String
  @Persisted var category: Int
  @Persisted var weatherType: Int
  @Persisted var descriptions: String?
  
  convenience init(id: String,
                   createdAt: Date,
                   imageURL: String,
                   category: Int,
                   weatherType: Int,
                   descriptions: String?) {
    self.init()
    self.id = id
    self.createdAt = createdAt
    self.imageURL = imageURL
    self.category = category
    self.weatherType = weatherType
    self.descriptions = descriptions
  }
}

// ViewModel에서 사용하기 위한 Mapping
extension ClothesEntity {
  func toModel() -> Clothes {
    Clothes(id: UUID(uuidString: id) ?? UUID(),
            createdAt: createdAt,
            imageURL: imageURL,
            category: ClothesCategory(rawValue: category) ?? .top,
            weatherType: WeatherType(rawValue: weatherType) ?? .allWeather,
            description: description)
  }
}
