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
      
      // TODO: 뷰모델에서 너무 많은 일을 함...
      // -> ClothesRepository에 저장하는 것으로 추상화하고, Repository 내부에서 Image저장 등을 알아서 처리하도록 해야 할 듯
      clothesStorage.save(clothes: clothes)
      
      guard let image = clothes.image else {
        didFailToSave.send("이미지가 존재하지 않습니다.")
        return
      }
      
      imageFileStorage.save(image: image, id: clothes.id)
        .print("스토리지지이이지")
        .sink(receiveCompletion: { [weak self] completion in
          switch completion {
          case .finished:
            self?.didSuccessToSave.send()
          case .failure:
            self?.didFailToSave.send("저장에 실패했습니다.")
          }
        }, receiveValue: {}) // Future<Void, Never> 이므로 따로 처리 X
        .store(in: &cancellables)
    }
    .store(in: &cancellables)
  }
}
