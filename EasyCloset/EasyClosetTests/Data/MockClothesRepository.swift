//
//  MockClothesRepository.swift
//  EasyClosetTests
//
//  Created by Mason Kim on 2023/05/28.
//
// swiftlint:disable all

@testable import EasyCloset
import Combine

final class MockClothesRepository: ClothesRepositoryProtocol {
  func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError> {
    return Just(ClothesList.mocks)
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func save(clothes: Clothes) -> AnyPublisher<Void, RepositoryError> {
    return Just(())
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func removeAll() {
    return
  }
}
