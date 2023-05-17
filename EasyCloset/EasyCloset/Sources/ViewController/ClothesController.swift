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
    static let collectionViewHeight: CGFloat = 160
    static let cellSize = CGSize(width: collectionViewHeight - 10, height: collectionViewHeight - 10)
  }
  
  // MARK: - Properties
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: carouselLayout
  ).then {
    $0.backgroundColor = .brown
  }
  
  private lazy var carouselLayout = CarouselFlowLayout().then {
    $0.itemSize = Metric.cellSize
    $0.scrollDirection = .horizontal
  }
  
  private lazy var dataSource: DataSource = DataSource(
    collectionView: collectionView,
    cellProvider: { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: ClothesCell.self, for: indexPath)
      if indexPath.row == 0 {
        collectionView.cellForItem(at: indexPath)
      }
      cell.configure(with: item)
      return cell
    })
  
  enum Section: CaseIterable {
    case top
    case bottom
    case shoes
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Clothes>
    
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
    let mockClothes = (0..<10).map { _ in Clothes.mock }
    appendSnapshot(with: mockClothes)
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
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(Metric.collectionViewHeight)
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: ClothesCell.self)
    setupInitialSnapshot()
  }
  
  // TODO: - Carousel Layout 구현
  private func collectionViewLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalWidth(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(120),
                                           heightDimension: .estimated(120))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    
    section.interGroupSpacing = 4
    return UICollectionViewCompositionalLayout(section: section)
  }
}

// MARK: - UICollectionView DataSource / Snapshot

extension ClothesController {
  private func setupInitialSnapshot() {
    var snapshot = dataSource.snapshot()
    snapshot.appendSections(Section.allCases)
    dataSource.apply(snapshot)
  }
  
  private func appendSnapshot(with items: [Clothes]) {
    var listSnapshot = NSDiffableDataSourceSectionSnapshot<Clothes>()
    listSnapshot.append(items)
    dataSource.apply(listSnapshot, to: .top)
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
