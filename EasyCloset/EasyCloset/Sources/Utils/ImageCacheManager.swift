//
//  ImageCacheManager.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

final class ImageCacheManager {
  
  // MARK: - Properties
  static let shared = ImageCacheManager()
  private let cacheManager =  NSCache<NSString, UIImage>()
  
  // MARK: - LifeCycle
  
  private init() {}
  
  // MARK: - Public
  
  func get(for key: String) -> UIImage? {
    cacheManager.object(forKey: key as NSString)
  }
  
  func store(_ value: UIImage, for key: String) {
    cacheManager.setObject(value, forKey: key as NSString)
  }
  
}
