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

final class ClothesRepository: ClothesRepositoryProtocol, ImageFetchable {
  
  // MARK: - Properties
  
  static let shared = ClothesRepository()
  
  private let realmStorage: RealmStorageProtocol
  
  private var cancellables = Set<AnyCancellable>()
  
  private init(realmStorage: RealmStorageProtocol = RealmStorage.shared) {
    self.realmStorage = realmStorage
    setupMockData()
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
    imageCacheManager.removeAll()
  }
  
  // MARK: - Private Methods
  
  // 초기 데이터가 없을 때 테스트 용도로 Mock 데이터를 저장 해 주는 메서드
#if DEBUG
  private func setupMockData() {
    guard realmStorage.load(entityType: ClothesEntity.self).isEmpty else { return }
    
    ClothesList.mock.clothesByCategory.forEach { (_, value: [Clothes]) in
      value.forEach { clothes in
        save(clothes: clothes)
          .sink(receiveCompletion: { _ in }, receiveValue: { })
          .store(in: &cancellables)
      }
    }
  }
#endif
}
