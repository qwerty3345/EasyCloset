//
//  StyleViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation

import Combine

final class StyleViewModel {
  
  // MARK: - Properties
  
  @Published private(set) var styles = [Style]()
  
  let stylesDidUpdate = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: StyleRepositoryProtocol
  
  // MARK: - Initialization
  
  init(repository: StyleRepositoryProtocol = StyleRepository.shared) {
    self.repository = repository
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    repository.fetchStyles()
      .map(sortByNew)
      .sink { completion in
        if case let .failure(error) = completion {
          print(error)
        }
      } receiveValue: { styles in
        self.styles = styles
      }
      .store(in: &cancellables)
    
    stylesDidUpdate
      .flatMap { [weak self] in
        guard let self = self else { return Empty<[Style], RepositoryError>().eraseToAnyPublisher() }
        return self.repository.fetchStyles()
      }
      .sink { completion in
        if case let .failure(error) = completion {
          print(error)
        }
      } receiveValue: { [weak self] styles in
        self?.styles = styles
      }
      .store(in: &cancellables)
  }
  
  private func sortByNew(to styles: [Style]) -> [Style] {
    return styles.sorted { $0.createdAt > $1.createdAt }
  }
}
