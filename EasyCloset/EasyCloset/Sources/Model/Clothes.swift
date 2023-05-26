//
//  Clothes.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

struct Clothes: Hashable, ImagableModel {
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

// MARK: - [Clothes] 를 ClothesList 타입으로 변환
// Why: dictionary 의 key값으로 category를 매칭시켜 각 옷 종류에 따른 옷들에 접근 시 O(1)으로 접근하게 하기 위함
extension Array where Element == Clothes {
  func toClothesDictionary() -> [ClothesCategory: Clothes] {
    return reduce(into: [ClothesCategory: Clothes](), { result, clothes in
      result[clothes.category] = clothes
    })
  }
  
  func toClothesList() -> ClothesList {
    return reduce(into: ClothesList(clothesByCategory: [:]), { result, clothes in
      result.clothesByCategory[clothes.category, default: []].append(clothes)
    })
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
  enum Mock {
    static let top1 = Clothes(image: .Sample.tshirt1, category: .top,
                              weatherType: .allWeather, descriptions: "tshirt1")
    static let top2 = Clothes(image: .Sample.tshirt2, category: .top,
                              weatherType: .allWeather, descriptions: "tshirt2")
    static let top3 = Clothes(image: .Sample.shirt1, category: .top,
                              weatherType: .allWeather, descriptions: "shirt1")
    static let bottom1 = Clothes(image: .Sample.pants1, category: .bottom,
                                 weatherType: .allWeather, descriptions: "pants1")
    static let bottom2 = Clothes(image: .Sample.pants2, category: .bottom,
                                 weatherType: .allWeather, descriptions: "pants2")
    static let bottom3 = Clothes(image: .Sample.shortpants, category: .bottom,
                                 weatherType: .allWeather, descriptions: "shortpants")
    static let accessory1 = Clothes(image: .Sample.cap1, category: .accessory,
                                    weatherType: .allWeather, descriptions: "cap1")
    static let accessory2 = Clothes(image: .Sample.socks1, category: .accessory,
                                    weatherType: .allWeather, descriptions: "socks1")
    static let outer1 = Clothes(image: .Sample.jacket1, category: .outer,
                                weatherType: .allWeather, descriptions: "jacket1")
    static let shoes1 = Clothes(image: .Sample.shoes1, category: .shoes,
                                weatherType: .allWeather, descriptions: "shoes1")
  }
}
