//
//  ClothesStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation
import RealmSwift

import Then

protocol ClothesStorageProtocol {
  func fetchClothesList() -> ClothesList?
  func save(clothes: Clothes)
}

struct ClothesStorage: ClothesStorageProtocol {
  
  // MARK: - Singleton
  
  static let shared = ClothesStorage()
  private init() { }
  
  // MARK: - Properties
  
  private let realm = try? Realm()
  
  // MARK: - Public Methods
  
  func fetchClothesList() -> ClothesList? {
    guard let realm = realm else { return nil }
    
    return realm.objects(ClothesEntity.self)
      .map { entity in
        var model = entity.toModelWithoutImage()
        model.image = ImageFileStorage.shared.load(withID: model.id)
        return model
      }
      .reduce(into: ClothesList(clothesByCategory: [:]), { result, clothes in
        result.clothesByCategory[clothes.category, default: []].append(clothes)
      })
  }
  
  func save(clothes: Clothes) {
    guard let realm = realm else { return }
    
    let clothesList = realm.objects(ClothesEntity.self)
    
    let idString = clothes.id.uuidString
    
    let clothesEntity = clothes.toEntity()
    
    try? realm.write {
      realm.add(clothesEntity, update: .modified) // PrimaryKey가 같은 항목은 업데이트
    }
  }
  
  func removeAll() {
    guard let realm = realm else { return }
    let clothesList = realm.objects(ClothesEntity.self)
    
    try? realm.write {
      realm.delete(clothesList)
    }
  }
}
