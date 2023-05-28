//
//  UITabBarController+Transition.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

extension UITabBarController {
  
  func moveWithAnimation(to index: Int) {
    guard let destinationViewController = viewControllers?[safe: index] else { return }
    moveWithAnimation(to: destinationViewController)
  }
  
  func moveWithAnimation(to viewController: UIViewController) {
    guard let selectedView = selectedViewController?.view,
          let destinationView = viewController.view,
          selectedView != destinationView else { return }
    
    UIView.transition(from: selectedView,
                      to: destinationView,
                      duration: 0.3,
                      options: [.transitionCrossDissolve])
    
    selectedViewController = viewController
  }
}
