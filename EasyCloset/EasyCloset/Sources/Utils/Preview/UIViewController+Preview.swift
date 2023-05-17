//
//  UIViewController+Preview.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit
import SwiftUI

#if DEBUG
extension UIViewController {
  private struct Preview: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
      return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
  }
  
  func toPreview() -> some View {
    Preview(viewController: self)
  }
}
#endif
