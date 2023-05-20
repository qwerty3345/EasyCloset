//
//  WeatherType.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import Foundation

enum WeatherType: Int, CaseIterable {
  case allWeather
  case spring
  case summer
  case fall
  case winter
  
  var korean: String {
    switch self {
    case .allWeather:
      return "사계절"
    case .spring:
      return "봄"
    case .summer:
      return "여름"
    case .fall:
      return "가을"
    case .winter:
      return "겨울"
    }
  }
}
