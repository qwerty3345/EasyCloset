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
