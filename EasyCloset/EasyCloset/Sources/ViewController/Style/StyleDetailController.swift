//
//  StyleDetailController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/25.
//

import UIKit

import Then
import SnapKit

import Combine

final class StyleDetailController: UIViewController {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding: CGFloat = 20
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
  
  enum Section: Int, CaseIterable {
    case main
  }
  
  enum Item: Hashable {
    case notAdded(ClothesCategory)
    case clothes(Clothes)
    
    var category: ClothesCategory {
      switch self {
      case .notAdded(let category):
        return category
      case .clothes(let clothes):
        return clothes.category
      }
    }
  }
  
  // MARK: - Properties
  
  private let viewModel = StyleViewModel()
  
  private let type: StyleDetailControllerType
  
  private var isEditingMode = false {
    didSet {
      updateUI(withEditingMode: isEditingMode)
    }
  }
  
  private lazy var dataSource: DataSource = makeDataSource()
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: collectionViewFlowLayout)
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout().then {
    let itemWidth = view.frame.width / 2 - (Metric.padding) - 10
    $0.itemSize = .init(width: itemWidth, height: itemWidth)
    $0.minimumInteritemSpacing = Metric.padding / 2
  }
  
  private lazy var editAddBarButton = UIBarButtonItem(
    title: type.rightBarButtonTitle,
    style: .plain,
    target: self,
    action: #selector(tappedEditAddButton))
  
  // MARK: - Initialization
  
  init(type: StyleDetailControllerType) {
    self.type = type
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    
  }
  
  // 편집 모드 상태에 따라 UI를 업데이트
  private func updateUI(withEditingMode isEditingMode: Bool) {
    guard case let .showDetail(style: style) = type else { return }
    
    editAddBarButton.title = isEditingMode ? "완료" : "편집"
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    
    let clothesItems = style.clothes.values.map { Item.clothes($0) }
    snapshot.appendItems(clothesItems, toSection: .main)
    
    // 편집 모드가 켜졌을 때는, 추가되지 않은 의류종류의 셀을 표시함
    if isEditingMode {
      let categories = style.clothes.values.map { $0.category }
      
      let notAddedItems = ClothesCategory.allCases
        .filter { category in
          categories.contains(category) == false
        }
        .map { Item.notAdded($0) }
      snapshot.appendItems(notAddedItems, toSection: .main)
    }
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func tappedEditAddButton() {
    switch type {
    case .add:
      addStyle()
    case .showDetail:
      editStyle()
    }
  }
  
  private func addStyle() {
  }
  
  private func editStyle() {
    if isEditingMode {
      
    }
    isEditingMode.toggle()
  }
  
  private func showFailAlert(with title: String) {
    let alert = UIAlertController(title: title,
                                  message: nil, preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "확인", style: .default)
    alert.addAction(confirmAction)
    
    present(alert, animated: true)
  }
}

// MARK: - UI & Layout

extension StyleDetailController {
  
  private func setup() {
    setUI()
    setupLayout()
    setupCollectionView()
  }
  
  private func setUI() {
    title = type.title
    navigationItem.rightBarButtonItem = editAddBarButton
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.registerCell(cellClass: StyleDetailCell.self)
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(top: 0, left: Metric.padding,
                                               bottom: 0, right: Metric.padding)
    applySnapshot()
  }
}

// MARK: - DataSource

extension StyleDetailController {
  
  private func makeDataSource() -> DataSource {
    
    return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: StyleDetailCell.self, for: indexPath)
      
      switch item {
      case .notAdded(let category):
        cell.configure(category: category)
      case .clothes(let clothes):
        cell.configure(with: clothes)
      }
      return cell
    }
  }
  
  private func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    
    switch type {
    case .add:
      let items = ClothesCategory.allCases.map { Item.notAdded($0) }
      snapshot.appendItems(items, toSection: .main)
    case .showDetail(style: let style):
      let items = style.clothes.values.map { Item.clothes($0) }
      snapshot.appendItems(items, toSection: .main)
    }
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UICollectionViewDelegate

extension StyleDetailController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    guard isEditingMode else { return }
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    let addClothesController = StyleAddClothesController(category: item.category)
    addClothesController.delegate = self
    present(addClothesController, animated: true)
  }
}

// MARK: - StyleAddClothesControllerDelegate

extension StyleDetailController: StyleAddClothesControllerDelegate {
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectClothes clothes: Clothes) {
    print(clothes)
  }
  
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectEmpty category: ClothesCategory) {
    print(category)
  }
}

// MARK: - ClothesDetailControllerType

enum StyleDetailControllerType {
  case add
  case showDetail(style: Style)
  
  var title: String {
    switch self {
    case .add:
      return "스타일 추가하기"
    case .showDetail:
      return "스타일 상세보기"
    }
  }
  
  var rightBarButtonTitle: String {
    switch self {
    case .add:
      return "추가"
    case .showDetail:
      return "편집"
    }
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct StyleDetailControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = StyleDetailController(type: .showDetail(style: .Mock.style1))
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
