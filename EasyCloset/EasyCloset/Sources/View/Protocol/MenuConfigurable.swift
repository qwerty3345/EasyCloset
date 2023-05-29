//
//  MenuConfigurable.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/30.
//

import UIKit

/// 특정 아이템을 꾹 눌렀을 때 상세보기 / 삭제 를 구현하기 위한 Protocol
protocol MenuConfigurable {
  /// 선택된 아이템으로 이동
  func moveToSelectedItem(at indexPath: IndexPath)
  /// 선택된 아이템을 삭제
  func deleteSelectedItem(of indexPath: IndexPath)
  func configureMenuConfiguration(of indexPath: IndexPath) -> UIContextMenuConfiguration?
}

extension MenuConfigurable {
  func configureMenuConfiguration(of indexPath: IndexPath) -> UIContextMenuConfiguration? {
    guard indexPath.row != 0 else { return nil }
    
    let showDetailAction = UIAction(title: "상세 보기", image: UIImage(systemName: "eye"),
                                    handler: { _ in
      self.moveToSelectedItem(at: indexPath)
    })
    let deleteAction = UIAction(title: "삭제", image: UIImage(systemName: "trash.slash"),
                                attributes: .destructive, handler: { _ in
      self.deleteSelectedItem(of: indexPath)
    })
    
    let menuItems = [showDetailAction, deleteAction]
    return UIContextMenuConfiguration(actionProvider: { _ in
      UIMenu(title: "", options: [], children: menuItems)
    })
  }
}
