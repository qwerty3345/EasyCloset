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
  static var mocks: [Style] {
    [
      Style(clothes: [
        .top: Clothes(image: .Sample.tshirt1,
                      category: .top,
                      weatherType: .allWeather,
                      descriptions: "tshirt1"),
        .bottom: Clothes(image: .Sample.pants1,
                         category: .bottom,
                         weatherType: .allWeather,
                         descriptions: "pants1"),
        .outer: Clothes(image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        descriptions: "jacket1"),
        .accessory: Clothes(image: .Sample.cap1,
                            category: .accessory,
                            weatherType: .allWeather,
                            descriptions: "cap1"),
        .shoes: Clothes(image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        descriptions: "shoes1")
      ], weather: .fall, name: "가을용 옷"),
      
      Style(clothes: [
//        .top: Clothes(
//                      image: .Sample.shirt1,
//                      category: .top,
//                      weatherType: .allWeather,
//                      description: "shirt1"),
//        .bottom: Clothes(
//                         image: .Sample.pants2,
//                         category: .bottom,
//                         weatherType: .allWeather,
//                         description: "pants2"),
        .outer: Clothes(image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        descriptions: "jacket1"),
        .accessory: Clothes(image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            descriptions: "socks1"),
        .shoes: Clothes(image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        descriptions: "shoes1")
      ], weather: .winter, name: "겨울용 옷"),
      
      Style(clothes: [
//        .top: Clothes(
//                      image: .Sample.tshirt2,
//                      category: .top,
//                      weatherType: .allWeather,
//                      description: "tshirt2"),
//        .bottom: Clothes(
//                         image: .Sample.shortpants,
//                         category: .bottom,
//                         weatherType: .allWeather,
//                         description: "shortpants"),
        .accessory: Clothes(image: .Sample.cap1,
                            category: .accessory,
                            weatherType: .allWeather,
                            descriptions: "cap1"),
        .shoes: Clothes(image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        descriptions: "shoes1")
      ], weather: .summer, name: "여름용 옷"),
      
      Style(clothes: [
        .top: Clothes(image: .Sample.shirt2,
                      category: .top,
                      weatherType: .allWeather,
                      descriptions: "shirt2"),
        .bottom: Clothes(image: .Sample.pants3,
                         category: .bottom,
                         weatherType: .allWeather,
                         descriptions: "pants3"),
        .outer: Clothes(image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        descriptions: "jacket1"),
        .accessory: Clothes(image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            descriptions: "socks1"),
        .shoes: Clothes(image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        descriptions: "shoes1")
      ], weather: .spring, name: "봄용 옷"),
      
      Style(clothes: [
        .top: Clothes(image: .Sample.shirt2,
                      category: .top,
                      weatherType: .allWeather,
                      descriptions: "shirt2"),
        .bottom: Clothes(image: .Sample.pants3,
                         category: .bottom,
                         weatherType: .allWeather,
                         descriptions: "pants3"),
        .outer: Clothes(image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        descriptions: "jacket1"),
        .accessory: Clothes(image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            descriptions: "socks1"),
        .shoes: Clothes(image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        descriptions: "shoes1")
      ], weather: .spring, name: "봄용 옷")
    ]
  }
}
