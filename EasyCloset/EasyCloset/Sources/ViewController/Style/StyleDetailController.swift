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
  
  private let nameTextField = UITextField().then {
    $0.font = .pretendardMediumTitle
    $0.textAlignment = .center
    $0.placeholder = "스타일의 이름을 입력 해 주세요"
    $0.isUserInteractionEnabled = false
    $0.layer.borderColor = UIColor.accentColor.cgColor
    $0.layer.cornerRadius = 8
  }
  
  private lazy var weatherSegmentedControl = UISegmentedControl(
    items: WeatherType.allCases.map { $0.korean }
  ).then {
    $0.isUserInteractionEnabled = false
  }
  
  // MARK: - Initialization
  
  init(type: StyleDetailControllerType) {
    self.type = type
    super.init(nibName: nil, bundle: nil)
    
    if case .showDetail(let style) = type {
      viewModel.styleToEdit = style
      configureUI(with: style)
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
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    turnEditMode()
    applySnapshot()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    viewModel.$styleToEdit
      .sink { [weak self] _ in
        guard let self = self else { return }
        DispatchQueue.main.async {
          self.applySnapshot()
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
  
  private func applySnapshot() {
    guard let style = viewModel.styleToEdit else { return }
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    
    let clothesItems = style.clothes.values.map { Item.clothes($0) }
    snapshot.appendItems(clothesItems, toSection: .main)
    
    // 편집 모드가 켜졌을 때는, 추가되지 않은 의류종류의 셀을 표시함
    if isEditing {
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
    saveStyleFromUserInput()
    navigationController?.popViewController(animated: true)
  }
  
  private func editStyle() {
    if isEditing {
      saveStyleFromUserInput()
    }
  }
  
  private func saveStyleFromUserInput() {
    viewModel.styleToEdit?.name = nameTextField.text
    viewModel.styleToEdit?.weather = WeatherType(rawValue: weatherSegmentedControl.selectedSegmentIndex) ?? .allWeather
    viewModel.saveStyle.send()
    delegate?.styleDetailController(didUpdateOrSave: self)
  }
  
  private func showFailAlert(with title: String) {
    let alert = UIAlertController(title: title,
                                  message: nil, preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "확인", style: .default)
    alert.addAction(confirmAction)
    
    present(alert, animated: true)
  }
  
  private func turnEditMode() {
    nameTextField.isUserInteractionEnabled = isEditing
    weatherSegmentedControl.isUserInteractionEnabled = isEditing
    nameTextField.layer.borderWidth = isEditing ? 1 : 0
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
    navigationItem.rightBarButtonItem = editButtonItem
    view.backgroundColor = .background
    collectionView.backgroundColor = .background
  }
  
  private func configureUI(with style: Style) {
    nameTextField.text = style.name ?? ""
    weatherSegmentedControl.selectedSegmentIndex = style.weather.rawValue
  }
  
  private func setupLayout() {
    view.addSubview(nameTextField)
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.equalToSuperview().inset(Metric.padding)
      $0.height.equalTo(30)
    }
    
    view.addSubview(weatherSegmentedControl)
    weatherSegmentedControl.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(Metric.padding)
      $0.horizontalEdges.equalToSuperview().inset(Metric.padding)
      $0.height.equalTo(30)
    }
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.equalTo(weatherSegmentedControl.snp.bottom).offset(Metric.padding)
      $0.horizontalEdges.bottom.equalToSuperview()
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
    if case .showDetail = type, isEditing == false {
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
    if viewModel.styleToEdit == nil {
      guard let weather = WeatherType(
        rawValue: weatherSegmentedControl.selectedSegmentIndex) else { return }
      viewModel.styleToEdit = Style(clothes: [:], weather: weather)
    }
    
    viewModel.styleToEdit?.clothes[clothes.category] = clothes
  }
  
  func styleAddClothesController(_ viewController: StyleAddClothesController,
                                 didSelectEmpty category: ClothesCategory) {
    viewModel.styleToEdit?.clothes.removeValue(forKey: category)
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
      return "상세보기"
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
