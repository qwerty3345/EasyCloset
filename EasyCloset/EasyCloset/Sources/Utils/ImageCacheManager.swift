//
//  ImageCacheManager.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

final class ImageCacheManager {
  
  // MARK: - Constants
  
  private enum Constants {
    static let megaByteUnit = 1024 * 1024
  }
  
  // MARK: - Singleton
  
  static let shared = ImageCacheManager()
  
  private init() {
    cache.countLimit = countLimit
    cache.totalCostLimit = byteLimit
  }
  
  // MARK: - Properties
  
  private let cache = NSCache<NSString, UIImage>()
  
  // 총 100개 까지만 FIFO로 캐싱함
  var countLimit = 100 {
    didSet { cache.countLimit = countLimit }
  }
  // 메모리 캐싱에 (대략) 200메가바이트 만큼 제약을 줌
  var megaByteLimit = 200 {
    didSet { cache.totalCostLimit = byteLimit }
  }
  private var byteLimit: Int {
    megaByteLimit * Constants.megaByteUnit
  }
  
  // MARK: - Public Methods
  
  func get(for id: UUID) -> UIImage? {
    cache.object(forKey: id.uuidString as NSString)
  }
  
  func store(_ value: UIImage, for id: UUID) {
    let bytesOfImage = value.pngData()?.count ?? 0
    cache.setObject(value, forKey: id.uuidString as NSString, cost: bytesOfImage)
  }
  
  func removeAll() {
    cache.removeAllObjects()
  }
  
}
