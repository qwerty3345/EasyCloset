//
//  StyleDetailViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

import Combine

final class StyleDetailViewModel {
  
  // MARK: - Properties
  
  @Published var style: Style?
  
  let didSuccessToSave = PassthroughSubject<Void, Never>()
  let didFailToSave = PassthroughSubject<String, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: StyleRepositoryProtocol
  
  // MARK: - Initialization
  
  init(repository: StyleRepositoryProtocol = StyleRepository.shared) {
    self.repository = repository
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    $style.sink { [weak self] style in
      guard let self = self,
            let style = style else { return }
      
      self.repository.save(style: style)
        .sink(receiveCompletion: { [weak self] completion in
          switch completion {
          case .finished:
            self?.didSuccessToSave.send()
          case .failure(let error):
            self?.didFailToSave.send(error.localizedDescription)
          }
        }, receiveValue: { })
        .store(in: &cancellables)
    }
    .store(in: &cancellables)
  }
}
