//
//  ClothesRepository.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/25.
//

import UIKit
import RealmSwift

import Combine

import Then

// MARK: - Protocol, RepositoryError

protocol ClothesRepositoryProtocol {
  func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError>
  func save(clothes: Clothes) -> Future<Void, RepositoryError>
  func removeAll()
}

enum RepositoryError: LocalizedError {
  case invalidImage
  case invalidData
  case transferError(error: Error)
  case failToSave
  
  var errorDescription: String? {
    switch self {
    case .invalidImage:
      return "이미지가 올바르지 않습니다."
    case .invalidData:
      return "데이터가 잘못되었습니다."
    case .transferError(let error):
      return "에러가 발생했습니다. \(error)"
    case .failToSave:
      return "저장에 실패했습니다."
    }
  }
}

// MARK: - ClothesRepository

final class ClothesRepository: ClothesRepositoryProtocol {
  
  // MARK: - Properties
  
  static let shared = ClothesRepository()
  
  private let imageFileStorage: ImageFileStorageProtocol
  private let realmStorage: RealmStorageProtocol
  private let imageCacheManager: ImageCacheManager = .shared
  
  private var cancellables = Set<AnyCancellable>()
  
  private init(imageFileStorage: ImageFileStorageProtocol = ImageFileStorage.shared,
               realmStorage: RealmStorageProtocol = RealmStorage.shared) {
    self.imageFileStorage = imageFileStorage
    self.realmStorage = realmStorage
  }
  
  // MARK: - Public Methods
  
  func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      // 반영한 모델들을 다 합한 결과를 future로 내뱉음.
      let clothesEntities = realmStorage.load(entityType: ClothesEntity.self)
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
  
  func save(clothes: Clothes) -> Future<Void, RepositoryError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      let clothesEntity = clothes.toEntity()
      if self.realmStorage.save(clothesEntity) == false {
        promise(.failure(.failToSave))
      }
      
      guard let image = clothes.image else {
        promise(.failure(.invalidImage))
        return
      }
      
      // 캐시 저장
      imageCacheManager.store(image, for: clothes.id)
      
      // 이미지 파일 저장
      imageFileStorage.save(image: image, id: clothes.id)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .finished:
            promise(.success(()))
          case .failure:
            promise(.failure(.failToSave))
          }
        }, receiveValue: {})
        .store(in: &cancellables)
    }
  }
  
  func removeAll() {
    realmStorage.removeAll(entityType: ClothesEntity.self)
    // 이미지도 전체 삭제 구현
    imageCacheManager.removeAll()
  }
  
  // MARK: - Private Methods
  
  private func addingImages(to clothesModels: [Clothes]) -> AnyPublisher<[Clothes], Never> {
    // ImageFileStorage를 호출해 이미지를 로딩해서 clothes에 넣는 것을 처리하는 Publisher들
    let clothesWithImagePublishers: [AnyPublisher<Clothes, Never>] = clothesModels.map { model in
      
      // 캐시된 이미지가 존재할 경우, 캐시에서 return
      if let image = imageCacheManager.get(for: model.id) {
        var clothes = model
        clothes.image = image
        return Just(clothes).eraseToAnyPublisher()
      }
      
      return ImageFileStorage.shared.load(withID: model.id)
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
