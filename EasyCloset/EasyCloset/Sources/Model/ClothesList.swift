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
            Clothes(image: .Sample.tshirt1, category: .top,
                    weatherType: .allWeather, descriptions: "tshirt1"),
            Clothes(image: .Sample.tshirt2, category: .top,
                    weatherType: .allWeather, descriptions: "tshirt2"),
            Clothes(image: .Sample.shirt1, category: .top,
                    weatherType: .allWeather, descriptions: "shirt1"),
            Clothes(image: .Sample.shirt2, category: .top,
                    weatherType: .allWeather, descriptions: "shirt2")
          ],
          .bottom: [
            Clothes(image: .Sample.pants1, category: .bottom,
                    weatherType: .allWeather, descriptions: "pants1"),
            Clothes(image: .Sample.pants2, category: .bottom,
                    weatherType: .allWeather, descriptions: "pants2"),
            Clothes(image: .Sample.pants3, category: .bottom,
                    weatherType: .allWeather, descriptions: "pants3"),
            Clothes(image: .Sample.shortpants, category: .bottom,
                    weatherType: .allWeather, descriptions: "shortpants")
          ],
          .accessory: [
            Clothes(image: .Sample.cap1, category: .accessory,
                    weatherType: .allWeather, descriptions: "cap1"),
            Clothes(image: .Sample.socks1, category: .accessory,
                    weatherType: .allWeather, descriptions: "socks1")
          ],
          .outer: [
            Clothes(image: .Sample.jacket1, category: .outer,
                    weatherType: .allWeather, descriptions: "jacket1")
          ],
          .shoes: [
            Clothes(image: .Sample.shoes1, category: .shoes,
                    weatherType: .allWeather, descriptions: "shoes1")
          ]
        ]
    )
  }
}
