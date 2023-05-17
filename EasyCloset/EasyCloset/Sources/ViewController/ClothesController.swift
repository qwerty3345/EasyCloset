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
//    static let cellSize = CGSize(width: collectionViewHeight - 10, height: collectionViewHeight - 10)
  }
  
  // MARK: - Properties
  
  // MARK: - UI Components
  
//  private lazy var clothesCollectionViews = ClothesCategory.allCases
//    .reduce(into: [ClothesCategory: UICollectionView](), { result, category in
//      result[category] = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
//    })
  
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
  
//  private lazy var collectionView = UICollectionView(
//    frame: .zero,
//    collectionViewLayout: carouselLayout
//  ).then {
//    $0.backgroundColor = .brown
//  }
//
//  private lazy var carouselLayout = CarouselFlowLayout().then {
//    $0.itemSize = Metric.cellSize
//    $0.scrollDirection = .horizontal
//  }
  
//  private lazy var dataSource: DataSource = DataSource(
//    collectionView: collectionView,
//    cellProvider: { collectionView, indexPath, item in
//      let cell = collectionView.dequeueReusableCell(cellClass: ClothesCell.self, for: indexPath)
//      if indexPath.row == 0 {
//        cell.showAddPhotoImage()
//      } else {
//        cell.configure(with: item)
//      }
//
//      return cell
//    })
  
//  enum Section: CaseIterable {
//    case top
//    case bottom
//    case shoes
//  }
  
//  typealias DataSource = UICollectionViewDiffableDataSource<Section, Clothes>
    
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
//    let mockClothes = (0..<10).map { _ in Clothes.mock }
//    appendSnapshot(with: mockClothes)
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
    view.backgroundColor = .cyan
  }
  
  private func setupLayout() {
    view.addSubview(containerCollectionView)
    containerCollectionView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
//    view.addSubview(collectionView)
//    collectionView.snp.makeConstraints {
//      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//      $0.horizontalEdges.equalToSuperview()
//      $0.height.equalTo(Metric.collectionViewHeight)
//    }
  }
  
  private func setupCollectionView() {
//    collectionView.registerCell(cellClass: ClothesCell.self)
//    setupInitialSnapshot()
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

// MARK: - UICollectionView DataSource / Snapshot

//extension ClothesController {
//  private func setupInitialSnapshot() {
//    var snapshot = dataSource.snapshot()
//    snapshot.appendSections(Section.allCases)
//    dataSource.apply(snapshot)
//  }
//
//  private func appendSnapshot(with items: [Clothes]) {
//    var listSnapshot = NSDiffableDataSourceSectionSnapshot<Clothes>()
//    listSnapshot.append(items)
//    dataSource.apply(listSnapshot, to: .top)
//  }
//}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ClothesControllerPreview: PreviewProvider {
  static var previews: some View {
    UINavigationController(rootViewController: ClothesController()).toPreview()
  }
}
#endif
