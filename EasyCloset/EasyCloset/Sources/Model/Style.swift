//
//  Style.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

struct Style {
  let uuid: UUID
  var createdAt: Date
  var clothes: [Category: Clothes]
  var weather: WeatherType
  var name: String?
  var collageImage: UIImage?
  
  init(uuid: UUID = UUID(),
       createdAt: Date = Date(),
       clothes: [Category: Clothes],
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
