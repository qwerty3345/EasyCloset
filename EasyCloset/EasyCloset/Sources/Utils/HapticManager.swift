//
//  HapticManager.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/29.
//

import UIKit

enum HapticManager {
  
  static func fireImpact(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
  }
  
  static func fireNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
  }
}
