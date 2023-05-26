//
//  ImagableModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import UIKit

// Repository에서 객체에 이미지를 storage에서 가져와서 매핑하기 위한 모델
protocol ImagableModel {
  var id: UUID { get }
  var image: UIImage? { get set }
}
