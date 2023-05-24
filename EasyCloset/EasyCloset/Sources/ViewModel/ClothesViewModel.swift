//
//  ClothesViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

import Combine

final class ClothesViewModel {
  
  // MARK: - Properties
  
  @Published private(set) var clothesList = ClothesList(clothesByCategory: [:])
  
  let clothesListDidUpdate = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let clothesStorage: ClothesStorageProtocol
  private let imageFileStorage: ImageFileStorageProtocol
  
  // MARK: - Initialization
  
  // 1초 후에 로딩 되는 것을 테스트 함
  init(clothesStorage: ClothesStorageProtocol = ClothesStorage.shared,
       imageFileStorage: ImageFileStorageProtocol = ImageFileStorage.shared) {
    self.clothesStorage = clothesStorage
    self.imageFileStorage = imageFileStorage
    bind()
  }
  
  // MARK: - Public Methods
  
  func clothes(of category: ClothesCategory) -> AnyPublisher<[Clothes], Never> {
    $clothesList
      .map {
        $0.clothesByCategory[category] ?? []
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    if let fetchedClothesList = clothesStorage.fetchClothesList() {
      self.clothesList = fetchedClothesList
    }
    
    clothesListDidUpdate
      .compactMap { [weak self] in
        self?.clothesStorage.fetchClothesList()
      }
      .sink { [weak self] clothesList in
        self?.clothesList = clothesList
      }
      .store(in: &cancellables)
  }
}
