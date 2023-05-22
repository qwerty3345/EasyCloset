//
//  Style.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

struct Style: Hashable {
  let uuid: UUID
  var createdAt: Date
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
    self.uuid = uuid
    self.createdAt = createdAt
    self.clothes = clothes
    self.weather = weather
    self.name = name
  }
}

// MARK: - Mock Data

extension Style {
  static var mocks: [Style] {
    [
      Style(clothes: [
        .top: Clothes(imageURL: "",
                      image: .Sample.tshirt1,
                      category: .top,
                      weatherType: .allWeather,
                      description: "tshirt1"),
        .bottom: Clothes(imageURL: "",
                         image: .Sample.pants1,
                         category: .bottom,
                         weatherType: .allWeather,
                         description: "pants1"),
        .outer: Clothes(imageURL: "",
                        image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        description: "jacket1"),
        .accessory: Clothes(imageURL: "",
                            image: .Sample.cap1,
                            category: .accessory,
                            weatherType: .allWeather,
                            description: "cap1"),
        .shoes: Clothes(imageURL: "",
                        image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        description: "shoes1")
      ], weather: .fall, name: "가을용 옷"),
      
      Style(clothes: [
        .top: Clothes(imageURL: "",
                      image: .Sample.shirt1,
                      category: .top,
                      weatherType: .allWeather,
                      description: "shirt1"),
        .bottom: Clothes(imageURL: "",
                         image: .Sample.pants2,
                         category: .bottom,
                         weatherType: .allWeather,
                         description: "pants2"),
        .outer: Clothes(imageURL: "",
                        image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        description: "jacket1"),
        .accessory: Clothes(imageURL: "",
                            image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            description: "socks1"),
        .shoes: Clothes(imageURL: "",
                        image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        description: "shoes1")
      ], weather: .winter, name: "겨울용 옷"),
      
      Style(clothes: [
        .top: Clothes(imageURL: "",
                      image: .Sample.tshirt2,
                      category: .top,
                      weatherType: .allWeather,
                      description: "tshirt2"),
        .bottom: Clothes(imageURL: "",
                         image: .Sample.shortpants,
                         category: .bottom,
                         weatherType: .allWeather,
                         description: "shortpants"),
        .accessory: Clothes(imageURL: "",
                            image: .Sample.cap1,
                            category: .accessory,
                            weatherType: .allWeather,
                            description: "cap1"),
        .shoes: Clothes(imageURL: "",
                        image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        description: "shoes1")
      ], weather: .summer, name: "여름용 옷"),
      
      Style(clothes: [
        .top: Clothes(imageURL: "",
                      image: .Sample.shirt2,
                      category: .top,
                      weatherType: .allWeather,
                      description: "shirt2"),
        .bottom: Clothes(imageURL: "",
                         image: .Sample.pants3,
                         category: .bottom,
                         weatherType: .allWeather,
                         description: "pants3"),
        .outer: Clothes(imageURL: "",
                        image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        description: "jacket1"),
        .accessory: Clothes(imageURL: "",
                            image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            description: "socks1"),
        .shoes: Clothes(imageURL: "",
                        image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        description: "shoes1")
      ], weather: .spring, name: "봄용 옷"),
      
      Style(clothes: [
        .top: Clothes(imageURL: "",
                      image: .Sample.shirt2,
                      category: .top,
                      weatherType: .allWeather,
                      description: "shirt2"),
        .bottom: Clothes(imageURL: "",
                         image: .Sample.pants3,
                         category: .bottom,
                         weatherType: .allWeather,
                         description: "pants3"),
        .outer: Clothes(imageURL: "",
                        image: .Sample.jacket1,
                        category: .outer,
                        weatherType: .allWeather,
                        description: "jacket1"),
        .accessory: Clothes(imageURL: "",
                            image: .Sample.socks1,
                            category: .accessory,
                            weatherType: .allWeather,
                            description: "socks1"),
        .shoes: Clothes(imageURL: "",
                        image: .Sample.shoes1,
                        category: .shoes,
                        weatherType: .allWeather,
                        description: "shoes1")
      ], weather: .spring, name: "봄용 옷")
    ]
  }
}
