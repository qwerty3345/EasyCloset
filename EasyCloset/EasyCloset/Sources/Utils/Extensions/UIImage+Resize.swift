//
//  UIImage+Resize.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/23.
//

import UIKit

extension UIImage {
  func scaled(to newSize: CGSize, isKeepingRatio: Bool = true) -> UIImage {
    guard size != newSize else { return self }
    
    // 가로, 세로 변환 비율
    let widthRatio  = newSize.width  / size.width
    let heightRatio = newSize.height / size.height
    
    var scaledSize = newSize
    if isKeepingRatio {
      let scalingFactor = min(widthRatio, heightRatio)
      scaledSize = CGSize(width: size.width * scalingFactor,
                          height: size.height * scalingFactor)
    }
    
    let render = UIGraphicsImageRenderer(size: scaledSize)
    let renderedImage = render.image { _ in
      self.draw(in: CGRect(origin: .zero, size: scaledSize))
    }
    
    return renderedImage
  }
}
