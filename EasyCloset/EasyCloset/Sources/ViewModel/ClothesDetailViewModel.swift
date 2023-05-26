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
  
  @Published private(set) var clothes: Clothes?
  
  let didSuccessToSave = PassthroughSubject<Void, Never>()
  let didFailToSave = PassthroughSubject<String, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: ClothesRepositoryProtocol
  
  // MARK: - Initialization
  
  init(clothes: Clothes?,
       repository: ClothesRepositoryProtocol) {
    self.clothes = clothes
    self.repository = repository
  }
  
  // MARK: - Public Methods
  
  func save(clothes: Clothes) {
    self.clothes = clothes
    
    repository.save(clothes: clothes)
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
}
