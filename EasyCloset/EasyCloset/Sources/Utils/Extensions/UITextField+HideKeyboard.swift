//
//  UITextField+HideKeyboard.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/28.
//

import UIKit

extension UITextField {
  private static let hideKeyboardDelegateInstance = HideKeyboardDelegateImpl()
  
  /// 이 메서드는 UITextFieldDelegate 를 자체적으로 사용하므로, delegate를 설정하면 이 메서드는 무시됩니다.
  func setJustHideKeyboardWhenEnter() {
    self.delegate = UITextField.hideKeyboardDelegateInstance
  }
}

final class HideKeyboardDelegateImpl: NSObject, UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
