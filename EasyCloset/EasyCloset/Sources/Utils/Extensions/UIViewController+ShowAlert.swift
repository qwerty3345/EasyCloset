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
  
  /// 사용자에게 Alert로 확인/취소를 물어보고 결과값을 completion으로 반환
  /// - Parameters:
  ///   - title: 물어볼 내용 title
  ///   - completion: 확인 시 true, 취소 시 false를 completion으로 반환
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
