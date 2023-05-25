//
//  ImageFileStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

import Combine

protocol ImageFileStorageProtocol {
  func save(image: UIImage, id: UUID, completion: ((FileManagerError?) -> Void)?)
  func load(withID id: UUID, completion: @escaping (UIImage?) -> Void)
  func remove(withID id: UUID, completion: ((FileManagerError?) -> Void)?)
}

enum FileManagerError: Error {
  case invalidFilePath
  case invalidData
  case failToWrite(error: Error)
}

final class ImageFileStorage: ImageFileStorageProtocol {
  
  // MARK: - Singleton
  
  static let shared = ImageFileStorage()
  
  private init() { }
  
  // MARK: - Public Methods
  
  func save(image: UIImage, id: UUID, completion: ((FileManagerError?) -> Void)? = nil) {
    guard let data = image.pngData(),
          let filePath = filePath(of: id) else { return }
    
    DispatchQueue.global(qos: .utility).async {
      do {
        try data.write(to: filePath)
        completion?(nil)
      } catch {
        completion?(.failToWrite(error: error))
      }
    }
  }
  
  func load(withID id: UUID, completion: @escaping (UIImage?) -> Void) {
    guard let filePath = filePath(of: id) else {
      completion(nil)
      return
    }
    
    DispatchQueue.global().async {
      do {
        let data = try Data(contentsOf: filePath)
        let image = UIImage(data: data)
        completion(image)
      } catch {
        completion(nil)
      }
    }
  }
  
  func load(withID id: UUID) -> Future<UIImage, FileManagerError> {
    return Future { promise in
      guard let filePath = self.filePath(of: id) else {
        promise(.failure(.invalidFilePath))
        return
      }
      
      DispatchQueue.global().async {
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
    }
  }
  
  func remove(withID id: UUID, completion: ((FileManagerError?) -> Void)? = nil) {
    guard let filePath = filePath(of: id) else {
      completion?(.invalidFilePath)
      return
    }
    
    DispatchQueue.global(qos: .utility).async {
      do {
        try FileManager.default.removeItem(at: filePath)
        completion?(nil)
      } catch {
        completion?(.failToWrite(error: error))
      }
    }
  }
  
  // MARK: - Private Methods
  
  private func filePath(of id: UUID) -> URL? {
    guard var path = FileManager.default.urls(for: .documentDirectory,
                                              in: .userDomainMask).first else { return nil }
    let fileName = "\(id.uuidString).jpg"
    
    // iOS 16부터 deprecated 되기에 분기처리
    if #available(iOS 16.0, *) {
      path.append(path: fileName)
    } else {
      path = path.appendingPathComponent(fileName)
    }
    return path
  }
}
