//
//  ClothesFilterController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/24.
//

import UIKit

final class ClothesFilterController: UIViewController {
  
  // MARK: - Types
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
  
  enum Section: Int, CaseIterable {
    case sort
    case weather
    case clothes
  }
  
  enum Item: Hashable {
    case sort(SortBy)
    case weather(WeatherType)
    case clothes(ClothesCategory)
    
    var description: String {
      switch self {
      case .sort(let sort):
        return sort.korean
      case .weather(let weather):
        return weather.korean
      case .clothes(let clothes):
        return clothes.korean
      }
    }
  }
  
  // MARK: - Properties
  
  private lazy var collectionView = UICollectionView(frame: .zero,
                                                     collectionViewLayout: makeCollectionViewLayout())
  
  private lazy var dataSource: DataSource = makeDataSource()
  
//  private var selectedItems: [Section: Item] = [:]
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    applySnapshot()
  }
  
  // MARK: - Private Methods
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    collectionView.registerCell(cellClass: FilterCell.self)
    collectionView.dataSource = dataSource
    collectionView.delegate = self
  }
  
  private func makeCollectionViewLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                          heightDimension: .absolute(20))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(20))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: 50, leading: 0, bottom: 0, trailing: 0)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private func makeDataSource() -> DataSource {
    DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: FilterCell.self, for: indexPath)
      cell.filterLabel.text = item.description
      return cell
    }
  }
  
  private func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    
    let sortItems = SortBy.allCases.map { Item.sort($0) }
    let weatherItems = WeatherType.allCases.map { Item.weather($0) }
    let clothesItems = ClothesCategory.allCases.map { Item.clothes($0) }
    
    snapshot.appendItems(sortItems, toSection: .sort)
    snapshot.appendItems(weatherItems, toSection: .weather)
    snapshot.appendItems(clothesItems, toSection: .clothes)
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UICollectionViewDelegate

extension ClothesFilterController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    guard let section = Section(rawValue: indexPath.section) else { return }
    
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    switch item {
    case .sort(let sort):
      print(sort)
    case .weather(let weather):
      print(weather)
    case .clothes(let clothes):
      print(clothes)
    }
    
    collectionView.cellForItem(at: indexPath)?.backgroundColor = .blue
  }
}
