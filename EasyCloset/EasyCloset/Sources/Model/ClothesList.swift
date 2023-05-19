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
            Clothes(name: "tshirt1", imageURL: "", image: .Sample.tshirt1, category: .top),
            Clothes(name: "tshirt2", imageURL: "", image: .Sample.tshirt2, category: .top),
            Clothes(name: "shirt1", imageURL: "", image: .Sample.shirt1, category: .top),
            Clothes(name: "shirt2", imageURL: "", image: .Sample.shirt2, category: .top)
          ],
          .bottom: [
            Clothes(name: "pants1", imageURL: "", image: .Sample.pants1, category: .bottom),
            Clothes(name: "pants2", imageURL: "", image: .Sample.pants2, category: .bottom),
            Clothes(name: "pants3", imageURL: "", image: .Sample.pants3, category: .bottom),
            Clothes(name: "shortpants", imageURL: "", image: .Sample.shortpants, category: .bottom)
          ],
          .accessory: [
            Clothes(name: "cap1", imageURL: "", image: .Sample.cap1, category: .accessory),
            Clothes(name: "socks1", imageURL: "", image: .Sample.socks1, category: .accessory)
          ],
          .outer: [
            Clothes(name: "jacket1", imageURL: "", image: .Sample.jacket1, category: .outer)
          ],
          .shoes: [
            Clothes(name: "shoes1", imageURL: "", image: .Sample.shoes1, category: .shoes)
          ]
        ]
    )
  }
}
