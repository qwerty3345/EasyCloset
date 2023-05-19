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
      $0.backgroundColor = .accentColor
    }
  
  private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
    $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    $0.itemSize = CGSize(width: view.frame.width, height: Metric.collectionViewRowHeight)
  }
  
  private let filterButton = UIButton().then {
    $0.setImage(.filter, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.snp.makeConstraints { make in
      make.width.height.equalTo(24)
    }
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
    setupCollectionView()
  }
  
  private func setUI() {
    addLeftTitle(with: "MY CLOSET")
    setupFilterButton()
  }
  
  private func setupLayout() {
    view.addSubview(containerCollectionView)
    containerCollectionView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }
  
  private func setupCollectionView() {
    containerCollectionView.dataSource = self
    containerCollectionView.delegate = self
    containerCollectionView.registerCell(cellClass: CarouselCell.self)
    containerCollectionView.registerHeaderView(viewClass: ClothesCategoryHeaderView.self)
  }
  
  private func setupFilterButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
  }
}

// MARK: - UICollectionViewDataSource

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
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableHeaderView(
      ofType: ClothesCategoryHeaderView.self,
      for: indexPath)
    let category = ClothesCategory.allCases[indexPath.section]
    headerView.configure(with: category)
    return headerView
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ClothesController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 60)
  }
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
