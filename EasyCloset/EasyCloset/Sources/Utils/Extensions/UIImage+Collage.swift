//
//  UIImage+Collage.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/22.
//

import UIKit

extension Array where Element == UIImage {
  
  /// 여러 장의 UIImage를 콜라쥬 해서 하나의 이미지로 생성
  /// - Parameters:
  ///   - size: 콜라쥬 결과 이미지의 크기
  ///   - rows: 콜라쥬 시 처리 할 행의 수
  ///   - isKeepingRatio: 원본 이미지의 비율을 유지 할 것인지 (기본은 `true`)
  /// - Returns: 콜라쥬로 생성 한 이미지
  func collage(withSize size: CGSize, rows: Int, isKeepingRatio: Bool = true) -> UIImage {
    guard count > 1 else { return self.first ?? UIImage() }
    
    let columns = Int(round(Double(count) / Double(rows)))
    let tileSize = CGSize(width: size.width / CGFloat(columns),
                          height: size.height / CGFloat(rows))
    
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
