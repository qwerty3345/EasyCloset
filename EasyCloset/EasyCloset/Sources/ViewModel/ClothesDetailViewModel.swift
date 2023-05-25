//
//  ClothesDetailViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import Foundation

import Combine

final class ClothesDetailViewModel {
  
  // MARK: - Properties
  
  @Published var clothes: Clothes?
  
  let didSuccessToSave = PassthroughSubject<Void, Never>()
  let didFailToSave = PassthroughSubject<String, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: ClothesRepositoryProtocol
  
  // MARK: - Initialization
  
  init(repository: ClothesRepositoryProtocol = ClothesRepository.shared) {
    self.repository = repository
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    $clothes.sink { [weak self] clothes in
      guard let self = self,
            let clothes = clothes else { return }
      
      self.repository.save(clothes: clothes)
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
