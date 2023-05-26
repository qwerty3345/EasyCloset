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

protocol StyleDetailControllerDelegate: AnyObject {
  func styleDetailController(didUpdateOrSave viewController: StyleDetailController)
}

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
  
  private let viewModel = StyleDetailViewModel()
  
  private let type: StyleDetailControllerType
  
  private var isEditingMode = false {
    didSet {
      updateUIWithSnapshot()
    }
  }
  
  weak var delegate: StyleDetailControllerDelegate?
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
    
    if case .showDetail(let style) = type {
      viewModel.style = style
    }
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
    viewModel.$style
      .sink { [weak self] _ in
        guard let self = self else { return }
        DispatchQueue.main.async {
          self.updateUIWithSnapshot()
        }
      }
      .store(in: &cancellables)
    
    viewModel.didFailToSave
      .sink { [weak self] message in
        DispatchQueue.main.async {
          self?.showFailAlert(with: message)
        }
      }
      .store(in: &cancellables)
    
    viewModel.didSuccessToSave
      .sink { [weak self] in
        DispatchQueue.main.async {
          self?.dismiss(animated: true)
        }
      }
      .store(in: &cancellables)
  }
  
  private func updateUIWithSnapshot() {
    guard let style = viewModel.style else { return }
    
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
    delegate?.styleDetailController(didUpdateOrSave: self)
    navigationController?.popViewController(animated: true)
  }
  
  private func editStyle() {
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
    applyInitialSnapshot()
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
  
  private func applyInitialSnapshot() {
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
    if case .showDetail = type, isEditingMode == false {
      return
    }
    
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
    if viewModel.style == nil {
      // TODO: 스타일에 계절 정보 집어넣어야 함...
      viewModel.style = Style(clothes: [:], weather: .allWeather)
    }
    
    viewModel.style?.clothes[clothes.category] = clothes
    delegate?.styleDetailController(didUpdateOrSave: self)
  }
  
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectEmpty category: ClothesCategory) {
    viewModel.style?.clothes.removeValue(forKey: category)
    delegate?.styleDetailController(didUpdateOrSave: self)
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
    case .showDetail(let style):
      return "\(style.name ?? "") 상세보기"
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
