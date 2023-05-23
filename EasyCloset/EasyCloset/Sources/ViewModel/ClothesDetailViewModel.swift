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
  
  let clothes: CurrentValueSubject<Clothes, Never>
  
  let occuredErrorWhileSave = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let clothesStorage: ClothesStorageProtocol
  private let imageFileStorage: ImageFileStorageProtocol
  
  // MARK: - Initialization
  
  init(clothes: Clothes,
       clothesStorage: ClothesStorageProtocol = ClothesStorage.shared,
       imageFileStorage: ImageFileStorageProtocol = ImageFileStorage.shared) {
    self.clothes = CurrentValueSubject(clothes)
    self.clothesStorage = clothesStorage
    self.imageFileStorage = imageFileStorage
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    clothes.sink { [weak self] clothes in
      guard let self = self else { return }
      clothesStorage.save(clothes: clothes)
      if let image = clothes.image {
        do {
          try imageFileStorage.save(image: image, id: clothes.id)
        } catch {
          self.occuredErrorWhileSave.send()
        }
      }
    }
    .store(in: &cancellables)
  }
}
