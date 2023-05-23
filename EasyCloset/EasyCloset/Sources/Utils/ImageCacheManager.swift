//
//  ImageCacheManager.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

final class ImageCacheManager {
  
  // MARK: - Configuration
  
  private enum Configuration {
    static let countLimit = 100 // 총 100개 까지만 FIFO로 캐싱함
    static let megaByteLimit = 200 * megaByteUnit // 메모리 캐싱에 (대략) 200메가바이트 만큼 제약을 줌
    static let megaByteUnit = 1024 * 1024
  }
  
  // MARK: - Singleton
  
  static let shared = ImageCacheManager()
  
  private init() {
    cache.countLimit = Configuration.countLimit
    cache.totalCostLimit = Configuration.megaByteLimit
  }
  
  // MARK: - Properties
  
  private let cache = NSCache<NSString, UIImage>()
  
  // MARK: - Public Methods
  
  func get(for id: UUID) -> UIImage? {
    cache.object(forKey: id.uuidString as NSString)
  }
  
  func store(_ value: UIImage, for id: UUID) {
    let bytesOfImage = value.jpegData(compressionQuality: 1.0)?.count ?? 0
    cache.setObject(value, forKey: id.uuidString as NSString, cost: bytesOfImage)
  }
  
}
