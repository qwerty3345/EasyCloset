//
//  ClothesStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit
import RealmSwift

import Combine

import Then

protocol ClothesStorageProtocol {
  func fetchClothesList() -> AnyPublisher<ClothesList, StorageError>
  func save(clothes: Clothes)
  func removeAll()
}

enum StorageError: Error {
  case realmNotInitialized
}

final class ClothesStorage: ClothesStorageProtocol {
  
  // MARK: - Singleton
  
  static let shared = ClothesStorage()
  private init() { }
  
  // MARK: - Properties
  
  private let realm = try? Realm()
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Public Methods
  
  func fetchClothesList() -> AnyPublisher<ClothesList, StorageError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      guard let realm = realm else {
        promise(.failure(.realmNotInitialized))
        return
      }
      
      // 반영한 모델들을 다 합한 결과를 future로 내뱉음.
      let clothesEntities = Array(realm.objects(ClothesEntity.self))
      let clothesModelsWithoutImage = clothesEntities.map { $0.toModelWithoutImage() }
      
      addingImages(to: clothesModelsWithoutImage)
        .sink { clothesModels in
          // 이미지가 모두 반영 된 ClothesList
          let clothesList = clothesModels.toClothesList()
          promise(.success(clothesList))
        }
        .store(in: &cancellables)
    }
    .eraseToAnyPublisher()
  }
  
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
  
  // MARK: - Private Methods
  
  private func addingImages(to clothesModels: [Clothes]) -> AnyPublisher<[Clothes], Never> {
    // ImageFileStorage를 호출해 이미지를 로딩해서 clothes에 넣는 것을 처리하는 Publisher들
    let clothesWithImagePublishers: [AnyPublisher<Clothes, Never>] = clothesModels.map { model in
      ImageFileStorage.shared.load(withID: model.id)
        .replaceError(with: UIImage())
        .map { image in
          var clothes = model
          clothes.image = image
          return clothes
        }
        .eraseToAnyPublisher()
    }
    
    // 위에서 만든 단일의 Clothes를 방출하는 여러 Publisher들을 모아서 [Clothes] 를 방출하는 하나의 Publisher로 만듬
    return Publishers.MergeMany(clothesWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
  }
}
