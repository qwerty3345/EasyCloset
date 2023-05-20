//
//  ClothesList.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

struct ClothesList {
  let clothesByCategory: [ClothesCategory: [Clothes]]
  
  static var mock: ClothesList {
    ClothesList(
      clothesByCategory:
        [
          .top: [
            Clothes(imageURL: "", image: .Sample.tshirt1, category: .top, description: "tshirt1"),
            Clothes(imageURL: "", image: .Sample.tshirt2, category: .top, description: "tshirt2"),
            Clothes(imageURL: "", image: .Sample.shirt1, category: .top, description: "shirt1"),
            Clothes(imageURL: "", image: .Sample.shirt2, category: .top, description: "shirt2"),
          ],
          .bottom: [
            Clothes(imageURL: "", image: .Sample.pants1, category: .bottom, description: "pants1"),
            Clothes(imageURL: "", image: .Sample.pants2, category: .bottom, description: "pants2"),
            Clothes(imageURL: "", image: .Sample.pants3, category: .bottom, description: "pants3"),
            Clothes(imageURL: "", image: .Sample.shortpants, category: .bottom, description: "shortpants"),
          ],
          .accessory: [
            Clothes(imageURL: "", image: .Sample.cap1, category: .accessory, description: "cap1"),
            Clothes(imageURL: "", image: .Sample.socks1, category: .accessory, description: "socks1")
          ],
          .outer: [
            Clothes(imageURL: "", image: .Sample.jacket1, category: .outer, description: "jacket1")
          ],
          .shoes: [
            Clothes(imageURL: "", image: .Sample.shoes1, category: .shoes, description: "shoes1")
          ]
        ]
    )
  }
}
