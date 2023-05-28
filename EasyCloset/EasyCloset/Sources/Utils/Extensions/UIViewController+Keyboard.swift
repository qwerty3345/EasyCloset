//
//  UIViewController+Keyboard.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/28.
//

import UIKit

import Combine

extension UIViewController {
  /// 사용자가 키보드 표시/숨김에 따라 화면 위치를 따라 올려주고 내려줌
  /// - Parameter cancellables: 뷰컨트롤러가 해제되면서 함께 해제될 cancellables
  func setupManageViewPositionForKeyboard(_ cancellables: inout Set<AnyCancellable>) {
    let keyboardWillShowPublisher = NotificationCenter.default
      .publisher(for: UIResponder.keyboardWillShowNotification)
    let keyboardWillHidePublisher = NotificationCenter.default
      .publisher(for: UIResponder.keyboardWillHideNotification)
    
    // 키보드 프레임 높이 만큼 뷰를 위로 올림
    keyboardWillShowPublisher
      .compactMap {
        // 애니메이션이 끝난 후, 키보드의 높이
        ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
      }
      .filter { [weak self] _ in
        self?.view.frame.origin.y == 0
      }
      .sink { [weak self] keyboardHeight in
        self?.view.frame.origin.y -= keyboardHeight
      }
      .store(in: &cancellables)
    
    // 원래 상태대로 초기화
    keyboardWillHidePublisher
      .filter { [weak self] _ in
        self?.view.frame.origin.y != 0
      }
      .sink { [weak self] _ in
        self?.view.frame.origin.y = 0
      }
      .store(in: &cancellables)
  }
}
