//
//  ImageFetchable.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

import Combine
import UIKit

protocol ImageFetchable {
  var imageCacheManager: ImageCacheManager { get }
  var imageFileStorage: ImageFileStorageProtocol { get }
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], Never>
}

extension ImageFetchable {
  var imageCacheManager: ImageCacheManager { .shared }
  var imageFileStorage: ImageFileStorageProtocol { ImageFileStorage.shared }
  
  // storage에 저장된 이미지가 아직 로딩되지 않은 모델들에 이미지를 추가해서 매핑해줌
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], Never> {
    let modelsWithImagePublishers: [AnyPublisher<T, Never>] = imagableModels.map { imagableModel in
      if let image = imageCacheManager.get(for: imagableModel.id) {
        var model = imagableModel
        model.image = image
        return Just(model).eraseToAnyPublisher()
      }
      
      return imageFileStorage.load(withID: imagableModel.id)
        .replaceError(with: UIImage())
        .map { image in
          var model = imagableModel
          model.image = image
          return model
        }
        .eraseToAnyPublisher()
    }
    
    return Publishers.MergeMany(modelsWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
  }
}
