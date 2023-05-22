//
//  ClothesStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation
import RealmSwift

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
      .map {
        $0.toModel()
      }
      .reduce(into: ClothesList(clothesByCategory: [:]), { result, clothes in
        result.clothesByCategory[clothes.category, default: []].append(clothes)
      })
  }
  
  func save(clothes: Clothes) {
    guard let realm = realm else { return }
    
    let clothesList = realm.objects(ClothesEntity.self)
    
    // 이미 존재 할 시 저장 X
    let idString = clothes.id.uuidString
    guard clothesList.filter("id == '\(idString)'").first == nil else { return }
    
    let clothesEntity = clothes.toEntity()
    
    try? realm.write {
      realm.add(clothesEntity)
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
