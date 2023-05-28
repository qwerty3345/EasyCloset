//
//  MockStyleRepository.swift
//  EasyClosetTests
//
//  Created by Mason Kim on 2023/05/28.
//

@testable import EasyCloset
import Combine

final class MockStyleRepository: StyleRepositoryProtocol {
  func fetchStyles() -> AnyPublisher<[Style], RepositoryError> {
    return Just(Style.Mock.mocks)
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func save(style: Style) -> AnyPublisher<Void, RepositoryError> {
    return Just(())
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func removeAll() {
    return
  }
}
