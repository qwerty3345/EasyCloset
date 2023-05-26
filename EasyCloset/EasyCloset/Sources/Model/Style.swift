//
//  Style.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

struct Style: Hashable {
  let id: UUID
  let createdAt: Date
  var clothes: [ClothesCategory: Clothes]
  var weather: WeatherType
  var name: String?
  var collageImage: UIImage?
  
  init(uuid: UUID = UUID(),
       createdAt: Date = Date(),
       clothes: [ClothesCategory: Clothes],
       weather: WeatherType,
       name: String? = nil,
       collageImage: UIImage? = nil) {
    self.id = uuid
    self.createdAt = createdAt
    self.clothes = clothes
    self.weather = weather
    self.name = name
  }
}

// MARK: - Entity Mapping

extension Style {
  func toEntity() -> StyleEntity {
    StyleEntity(id: id.uuidString,
                createdAt: createdAt,
                clothes: clothes.values.map { $0.toEntity() },
                weatherType: weather.rawValue,
                name: name ?? "")
  }
}

// MARK: - Mock Data

extension Style {
  enum Mock {
    static let mocks = [style1, style2, style3, style4, style5]
    
    static let style1: Style = {
      var clothesByCategory: [ClothesCategory: Clothes] = [:]
      clothesByCategory[.top] = Clothes.Mock.top1
      clothesByCategory[.bottom] = Clothes.Mock.bottom1
      clothesByCategory[.outer] = Clothes.Mock.outer1
      clothesByCategory[.accessory] = Clothes.Mock.accessory1
      clothesByCategory[.shoes] = Clothes.Mock.shoes1
      return Style(clothes: clothesByCategory, weather: .fall, name: "가을용 옷")
    }()
    
    static let style2: Style = {
      var clothesByCategory: [ClothesCategory: Clothes] = [:]
      clothesByCategory[.top] = Clothes.Mock.top2
      clothesByCategory[.bottom] = Clothes.Mock.bottom2
      clothesByCategory[.outer] = Clothes.Mock.outer1
      clothesByCategory[.accessory] = Clothes.Mock.accessory2
      return Style(clothes: clothesByCategory, weather: .winter, name: "겨울용 옷")
    }()
    
    static let style3: Style = {
      var clothesByCategory: [ClothesCategory: Clothes] = [:]
      clothesByCategory[.top] = Clothes.Mock.top3
      clothesByCategory[.bottom] = Clothes.Mock.bottom3
      clothesByCategory[.outer] = Clothes.Mock.outer1
      return Style(clothes: clothesByCategory, weather: .spring, name: "봄용 옷")
    }()
   
    static let style4: Style = {
      var clothesByCategory: [ClothesCategory: Clothes] = [:]
      clothesByCategory[.top] = Clothes.Mock.top2
      clothesByCategory[.bottom] = Clothes.Mock.bottom1
      clothesByCategory[.outer] = Clothes.Mock.outer1
      clothesByCategory[.accessory] = Clothes.Mock.accessory2
      return Style(clothes: clothesByCategory, weather: .summer, name: "여름용 옷")
    }()
    
    static let style5: Style = {
      var clothesByCategory: [ClothesCategory: Clothes] = [:]
      clothesByCategory[.top] = Clothes.Mock.top3
      clothesByCategory[.bottom] = Clothes.Mock.bottom2
      clothesByCategory[.shoes] = Clothes.Mock.shoes1
      return Style(clothes: clothesByCategory, weather: .spring, name: "봄용 옷 2")
    }()
  }
}
