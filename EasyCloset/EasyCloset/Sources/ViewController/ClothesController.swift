//
//  ClothesController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import SnapKit
import Then

final class ClothesController: UIViewController {
  
  // MARK: - Constants
  
  private enum Metric {
    static let collectionViewRowHeight: CGFloat = 160
  }
  
  // MARK: - Properties
  
  // MARK: - UI Components

  
  private lazy var containerCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: collectionViewLayout).then {
      $0.dataSource = self
      $0.registerCell(cellClass: CarouselCell.self)
      $0.backgroundColor = .accentColor
    }
  
  private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
    $0.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    $0.itemSize = CGSize(width: view.frame.width, height: Metric.collectionViewRowHeight)
  }
    
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Public Methods
  
  // MARK: - Private Methods
  
}

// MARK: - UI & Layout

extension ClothesController {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    addLeftTitle(with: "MY CLOSET")
    view.backgroundColor = .cyan
  }
  
  private func setupLayout() {
    view.addSubview(containerCollectionView)
    containerCollectionView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }
  
}

//MARK: UICollectionViewDataSource

extension ClothesController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return ClothesCategory.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(cellClass: CarouselCell.self, for: indexPath)
    cell.category = ClothesCategory.allCases[indexPath.section]
    return cell
  }
  
  // TODO: - 헤더 설정 (상의, 하의...)
//  func collectionView(_ collectionView: UICollectionView,
//                      viewForSupplementaryElementOfKind kind: String,
//                      at indexPath: IndexPath) -> UICollectionReusableView {
//    let view = collectionView.dequeueReusableSupplementaryView(
//      ofKind: UICollectionView.elementKindSectionHeader,
//      withReuseIdentifier: <#identifier#>,
//      for: indexPath
//    )
//    return view
//  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ClothesControllerPreview: PreviewProvider {
  static var previews: some View {
    UINavigationController(rootViewController: ClothesController()).toPreview()
  }
}
#endif
