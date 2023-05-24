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
  
  private let clothesStorage: ClothesStorageProtocol
  private let imageFileStorage: ImageFileStorageProtocol
  
  // MARK: - Initialization
  
  init(clothesStorage: ClothesStorageProtocol = ClothesStorage.shared,
       imageFileStorage: ImageFileStorageProtocol = ImageFileStorage.shared) {
    self.clothesStorage = clothesStorage
    self.imageFileStorage = imageFileStorage
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    $clothes.sink { [weak self] clothes in
      guard let self = self,
            let clothes = clothes else { return }
      
      clothesStorage.save(clothes: clothes)
      
      guard let image = clothes.image else {
        didFailToSave.send("이미지가 존재하지 않습니다.")
        return
      }
      
      do {
        try imageFileStorage.save(image: image, id: clothes.id)
      } catch {
        didFailToSave.send("저장에 실패했습니다.")
      }
      
      didSuccessToSave.send()
    }
    .store(in: &cancellables)
  }
}
