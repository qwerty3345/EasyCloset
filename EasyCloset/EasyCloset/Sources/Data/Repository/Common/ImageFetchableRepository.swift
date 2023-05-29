//
//  ImageFetchableRepository.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

import Combine
import UIKit

protocol ImageFetchableRepository {
  var imageCacheManager: ImageCacheManager { get }
  var imageFileStorage: ImageFileStorageProtocol { get }
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], RepositoryError>
}

extension ImageFetchableRepository {
  var imageCacheManager: ImageCacheManager { .shared }
  
  // storage에 저장된 이미지가 아직 로딩되지 않은 모델들에 이미지를 추가해서 매핑해줌
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], RepositoryError> {
    // 모델이 비어있으면 fail 반환
    guard imagableModels.isEmpty == false else {
      return Fail(error: RepositoryError.invalidData)
        .eraseToAnyPublisher()
    }
    
    let modelsWithImagePublishers = imagableModels.map { imagableModel in
      if let image = imageCacheManager.get(for: imagableModel.id) {
        var model = imagableModel
        model.image = image
        return Just(model)
          .setFailureType(to: RepositoryError.self)
          .eraseToAnyPublisher()
      }
      
      return imageFileStorage.load(withID: imagableModel.id)
        .replaceError(with: UIImage())
        .map { image in
          var model = imagableModel
          imageCacheManager.store(image, for: model.id) // 메모리 캐시에 저장
          model.image = image
          return model
        }
        .setFailureType(to: RepositoryError.self)
        .eraseToAnyPublisher()
    }
    
    return Publishers.MergeMany(modelsWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
  }
}
