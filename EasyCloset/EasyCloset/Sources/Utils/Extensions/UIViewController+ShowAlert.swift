//
//  UIViewController+ShowAlert.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/27.
//

import UIKit

extension UIViewController {
  func showFailAlert(with title: String) {
    let alert = UIAlertController(title: title,
                                  message: nil, preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "확인", style: .default)
    alert.addAction(confirmAction)
    
    present(alert, animated: true)
  }
  
  func showAskAlert(title: String, completion: @escaping (Bool) -> Void) {
    let alert = UIAlertController(title: title,
                                  message: nil, preferredStyle: .alert)
    
    let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
      completion(true)
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
      completion(false)
    }
    alert.addAction(confirmAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
  }
}
