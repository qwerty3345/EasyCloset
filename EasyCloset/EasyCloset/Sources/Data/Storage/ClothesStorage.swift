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
  func fetchClothesList(completion: @escaping (ClothesList?) -> Void)
  func save(clothes: Clothes)
  func removeAll()
}

struct ClothesStorage: ClothesStorageProtocol {
  
  // MARK: - Singleton
  
  static let shared = ClothesStorage()
  private init() { }
  
  // MARK: - Properties
  
  private let realm = try? Realm()
  
  // MARK: - Public Methods
  
  func fetchClothesList(completion: @escaping (ClothesList?) -> Void) {
    guard let realm = realm else {
      completion(nil)
      return
    }
    
    let clothesEntities = realm.objects(ClothesEntity.self)
    var clothesList = ClothesList(clothesByCategory: [:])
    
    let dispatchGroup = DispatchGroup()
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    clothesEntities.forEach { entity in
      var model = entity.toModelWithoutImage()
      
      dispatchGroup.enter()
      
      ImageFileStorage.shared.load(withID: model.id) { image in
        if let image = image {
          model.image = image
        }
        // 딕셔너리에 동시 접근 때문에 발생하는 문제를 serialQueue로 방지
        serialQueue.async {
          clothesList.clothesByCategory[model.category, default: []].append(model)
        }
        dispatchGroup.leave()
      }
    }
    
    dispatchGroup.notify(queue: .main) {
      completion(clothesList)
    }
  }
  
//  func fetchClothesList() -> ClothesList? {
//    guard let realm = realm else { return nil }
//
//    return realm.objects(ClothesEntity.self)
//      .map { entity in
//        var model = entity.toModelWithoutImage()
//
//        // TODO: 얘가 비동기이기 때문에 이미지가 로드되기도 전에 기다리지 않고 넘어감. 또한 함수형으로 처리하기 힘들어짐... completion 내부로 처리해야 함..!
//        ImageFileStorage.shared.load(withID: model.id) { image in
//          if let image = image {
//            model.image = image
//          }
//        }
//        return model
//      }
//      .reduce(into: ClothesList(clothesByCategory: [:]), { result, clothes in
//        result.clothesByCategory[clothes.category, default: []].append(clothes)
//      })
//  }
  
  func save(clothes: Clothes) {
    guard let realm = realm else { return }
    
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
