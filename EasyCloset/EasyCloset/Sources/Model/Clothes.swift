//
//  Clothes.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

struct Clothes: Hashable {
  let id: UUID
  var name: String
  let createdAt: Date
  let imageURL: String
  var image: UIImage?
  var category: ClothesCategory
  
  init(id: UUID = UUID(),
       name: String,
       createdAt: Date = Date(),
       imageURL: String,
       image: UIImage?,
       category: ClothesCategory) {
    self.id = id
    self.name = name
    self.createdAt = createdAt
    self.imageURL = imageURL
    self.image = image
    self.category = category
  }
  
  static var mock: Clothes {
    Clothes(
      name: "\(Int.random(in: (1...100)))",
      imageURL: "",
      image: .Sample.cap1,
      category: .allCases.randomElement()!
    )
  }
}
