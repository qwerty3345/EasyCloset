//
//  ClothesList.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

struct ClothesList {
  var clothesByCategory: [ClothesCategory: [Clothes]]
}

// MARK: - Mock Data

extension ClothesList {
  static var mock: ClothesList {
    ClothesList(
      clothesByCategory:
        [
          .top: [
            Clothes(imageURL: "", image: .Sample.tshirt1, category: .top,
                    weatherType: .allWeather, description: "tshirt1"),
            Clothes(imageURL: "", image: .Sample.tshirt2, category: .top,
                    weatherType: .allWeather, description: "tshirt2"),
            Clothes(imageURL: "", image: .Sample.shirt1, category: .top,
                    weatherType: .allWeather, description: "shirt1"),
            Clothes(imageURL: "", image: .Sample.shirt2, category: .top,
                    weatherType: .allWeather, description: "shirt2")
          ],
          .bottom: [
            Clothes(imageURL: "", image: .Sample.pants1, category: .bottom,
                    weatherType: .allWeather, description: "pants1"),
            Clothes(imageURL: "", image: .Sample.pants2, category: .bottom,
                    weatherType: .allWeather, description: "pants2"),
            Clothes(imageURL: "", image: .Sample.pants3, category: .bottom,
                    weatherType: .allWeather, description: "pants3"),
            Clothes(imageURL: "", image: .Sample.shortpants, category: .bottom,
                    weatherType: .allWeather, description: "shortpants")
          ],
          .accessory: [
            Clothes(imageURL: "", image: .Sample.cap1, category: .accessory,
                    weatherType: .allWeather, description: "cap1"),
            Clothes(imageURL: "", image: .Sample.socks1, category: .accessory,
                    weatherType: .allWeather, description: "socks1")
          ],
          .outer: [
            Clothes(imageURL: "", image: .Sample.jacket1, category: .outer,
                    weatherType: .allWeather, description: "jacket1")
          ],
          .shoes: [
            Clothes(imageURL: "", image: .Sample.shoes1, category: .shoes,
                    weatherType: .allWeather, description: "shoes1")
          ]
        ]
    )
  }
}
