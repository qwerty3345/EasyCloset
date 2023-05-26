//
//  StyleEntity.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

import RealmSwift

final class StyleEntity: Object {
  @Persisted(primaryKey: true) var id: String
  @Persisted var createdAt: Date
  @Persisted var clothes: List<ClothesEntity>
  @Persisted var weatherType: Int
  @Persisted var name: String
  
  convenience init(id: String,
                   createdAt: Date,
                   clothes: [ClothesEntity],
                   weatherType: Int,
                   name: String) {
    self.init()
    self.id = id
    self.createdAt = createdAt
    self.clothes = clothes.reduce(into: List<ClothesEntity>()) { $0.append($1) } // Array 형태를 Realm의 List로 매핑
    self.weatherType = weatherType
    self.name = name
  }
}

// MARK: - Model Mapping
extension StyleEntity {
  func toModelWithoutImage() -> Style {
    return Style(uuid: UUID(uuidString: id) ?? UUID(),
                 createdAt: createdAt,
                 clothes: clothes.map { $0.toModelWithoutImage() }.toClothesDictionary(),
                 weather: WeatherType(rawValue: weatherType) ?? .allWeather,
                 name: name,
                 collageImage: nil)
  }
}
