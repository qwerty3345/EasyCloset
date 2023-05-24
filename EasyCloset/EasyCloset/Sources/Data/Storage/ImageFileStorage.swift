//
//  ImageFileStorage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

protocol ImageFileStorageProtocol {
  func save(image: UIImage, id: UUID) throws
  func load(withID id: UUID) -> UIImage?
  func remove(withID id: UUID) -> Bool
}

final class ImageFileStorage: ImageFileStorageProtocol {
  
  // MARK: - Singleton
  
  static let shared = ImageFileStorage()
  
  private init() { }
  
  // MARK: - Public Methods

  func save(image: UIImage, id: UUID) throws {
    guard let data = image.pngData(),
          let filePath = filePath(of: id) else { return }
    
    try data.write(to: filePath)
  }
  
  func load(withID id: UUID) -> UIImage? {
    guard let filePath = filePath(of: id) else { return nil }
    do {
      let data = try Data(contentsOf: filePath)
      return UIImage(data: data)
    } catch {
      return nil
    }
  }
  
  @discardableResult
  func remove(withID id: UUID) -> Bool {
    guard let filePath = filePath(of: id) else { return false }
    
    do {
      try FileManager.default.removeItem(at: filePath)
      return true
    } catch {
      return false
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
