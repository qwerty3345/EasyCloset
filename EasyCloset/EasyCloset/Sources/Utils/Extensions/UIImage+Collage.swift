//
//  UIImage+Collage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

extension Array where Element == UIImage {
  func collage(withSize size: CGSize, rows: Int, isKeepingRatio: Bool = true) -> UIImage {
    guard count > 1 else { return self.first ?? UIImage() }
    
    let columns = count > rows ? count / rows : 1
    let tileSize = CGSize(width: size.width / CGFloat(rows),
                          height: size.height / CGFloat(columns))
    
    let renderer = UIGraphicsImageRenderer(size: size)
    let collageImage = renderer.image { _ in
      UIColor.white.set()
      UIRectFill(CGRect(origin: .zero, size: size))
      
      enumerated().forEach { index, image in
        let scaledImage = image.scaled(to: tileSize, isKeepingRatio: isKeepingRatio)
        
        // 콜라주 이미지를 중앙으로 오게 하기 위한 이미지 시작점
        let xStartPoint = (tileSize.width - scaledImage.size.width) / 2
        let yStartPoint = (tileSize.height - scaledImage.size.height) / 2
        
        let tileDrawPoint = CGPoint(x: CGFloat(index % columns) * tileSize.width + xStartPoint,
                                    y: CGFloat(index / columns) * tileSize.height + yStartPoint)
        scaledImage.draw(at: tileDrawPoint)
      }
    }
    
    return collageImage
  }
}

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
