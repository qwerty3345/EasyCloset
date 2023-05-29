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

  let deleteStyle = PassthroughSubject<Style, Never>()
  let stylesDidUpdate = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: StyleRepositoryProtocol
  
  // MARK: - Initialization
  
  init(repository: StyleRepositoryProtocol) {
    self.repository = repository
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    stylesDidUpdate
      .prepend(()) // 초기에 값을 한 번 발행하여, fetchStyle를 실행함
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
    
    deleteStyle
      .sink { [weak self] style in
        self?.repository.remove(style: style)
        self?.stylesDidUpdate.send()
      }
      .store(in: &cancellables)
  }
  
  private func sortByNew(to styles: [Style]) -> [Style] {
    return styles.sorted { $0.createdAt > $1.createdAt }
  }
}
