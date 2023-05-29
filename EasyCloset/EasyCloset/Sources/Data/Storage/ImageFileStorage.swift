//
//  ImageFileStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

import Combine

// MARK: - Protocol, FileManagerError

protocol ImageFileStorageProtocol {
  func save(image: UIImage, id: UUID) -> AnyPublisher<Void, FileManagerError>
  func load(withID id: UUID) -> AnyPublisher<UIImage, FileManagerError>
  func remove(withID id: UUID) -> AnyPublisher<Void, FileManagerError>
  func removeAll() -> AnyPublisher<Void, FileManagerError>
}

enum FileManagerError: Error {
  case invalidFilePath
  case invalidData
  case failToWrite(error: Error)
}

// MARK: - ImageFileStorage

final class ImageFileStorage: ImageFileStorageProtocol {
  
  // MARK: - Properties
  
  private enum Constants {
    static let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    static let imageExtension = "png"
  }
  
  // MARK: - Public Methods
  
  @discardableResult
  func save(image: UIImage, id: UUID) -> AnyPublisher<Void, FileManagerError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      guard let data = image.pngData() else {
        promise(.failure(.invalidData))
        return
      }
      
      guard let filePath = self.filePath(of: id) else {
        promise(.failure(.invalidFilePath))
        return
      }
      
      do {
        try data.write(to: filePath)
        promise(.success(()))
      } catch {
        promise(.failure(.failToWrite(error: error)))
      }
    }
    .receive(on: DispatchQueue.global(qos: .utility))
    .eraseToAnyPublisher()
  }
  
  func load(withID id: UUID) -> AnyPublisher<UIImage, FileManagerError> {
    return Future { promise in
      guard let filePath = self.filePath(of: id) else {
        promise(.failure(.invalidFilePath))
        return
      }
      
      do {
        let data = try Data(contentsOf: filePath)
        guard let image = UIImage(data: data) else {
          promise(.failure(.invalidData))
          return
        }
        promise(.success(image))
      } catch {
        promise(.failure(.failToWrite(error: error)))
      }
    }
    .receive(on: DispatchQueue.global())
    .eraseToAnyPublisher()
  }
  
  func remove(withID id: UUID) -> AnyPublisher<Void, FileManagerError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      guard let filePath = filePath(of: id) else {
        promise(.failure(.invalidFilePath))
        return
      }
      
      do {
        try FileManager.default.removeItem(at: filePath)
        promise(.success(()))
      } catch {
        promise(.failure(.failToWrite(error: error)))
      }
    }
    .receive(on: DispatchQueue.global(qos: .utility))
    .eraseToAnyPublisher()
  }
  
  func removeAll() -> AnyPublisher<Void, FileManagerError> {
    return Future { promise in
      guard let path = Constants.path,
            let filePathURLs = try? FileManager.default.contentsOfDirectory(at: path,
                                                                            includingPropertiesForKeys: nil) else {
        promise(.failure(.invalidFilePath))
        return
      }
      
      let imagePathURLs = filePathURLs.filter {
        $0.pathExtension == Constants.imageExtension
      }
      
      // 중간에 삭제 작업이 실패해도 계속 이어나가기 위해, 발생한 에러들을 배열에 담으며 for문을 돌림
      var occuredErrors: [Error] = []
      
      for imagePathURL in imagePathURLs {
        do {
          try FileManager.default.removeItem(at: imagePathURL)
        } catch {
          // 여기서 promise(.failure()) 를 호출하면, 뒤의 아이템이 삭제되지 않고 조기종료 될 수 있기에...
          occuredErrors.append(error)
        }
        
        if let firstError = occuredErrors.first {
          promise(.failure(.failToWrite(error: firstError)))
          return
        }
        
        promise(.success(()))
      }
    }
    .receive(on: DispatchQueue.global(qos: .utility))
    .eraseToAnyPublisher()
  }
  
  // MARK: - Private Methods
  
  private func filePath(of id: UUID) -> URL? {
    guard var path = Constants.path else { return nil }
    let fileName = "\(id.uuidString).\(Constants.imageExtension)"
    
    // iOS 16부터 deprecated 되기에 분기처리
    if #available(iOS 16.0, *) {
      path.append(path: fileName)
    } else {
      path = path.appendingPathComponent(fileName)
    }
    return path
  }
}
