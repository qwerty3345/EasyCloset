//
//  UICollectionView+RegisterCell.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
  func registerCell<T: UICollectionViewCell>(cellClass: T.Type) {
    register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue Reusable TableView cell")
    }
    return cell
  }
}
