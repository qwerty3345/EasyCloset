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
    static let initialByteLimit = 200 * megaByteUnit // 초기 제약: 200메가바이트
    static let kiloByteUnit = 1024
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
  // 메모리 캐싱 시의 용량 제약 (기본값: 200메가바이트)
  var byteLimit: Int = Constants.initialByteLimit {
    didSet { cache.totalCostLimit = byteLimit }
  }
  var megaByteLimit: Int {
    get { byteLimit / Constants.megaByteUnit }
    set { byteLimit = newValue * Constants.megaByteUnit }
  }
  var kiloByteLimit: Int {
    get { byteLimit / Constants.kiloByteUnit }
    set { byteLimit = newValue * Constants.kiloByteUnit }
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
