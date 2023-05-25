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
  
  // MARK: - Properties
  
  private let viewModel = StyleViewModel()
  
  private let type: StyleDetailControllerType
  
  private var isEditingStyle = false {
    didSet {
      turnEditMode(isOn: isEditingStyle)
    }
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  private lazy var colletionView = UICollectionView(
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
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    
  }
  
  private func configure(with style: Style) {
    guard case .showDetail = type else { return }
    
//    photoHandlingView.setImage(clothes.image)
//    categotyPickerView.selectRow(clothes.category.rawValue,
//                                 inComponent: 0, animated: false)
//    weatherSegmentedControl.selectedSegmentIndex = clothes.weatherType.rawValue
//    descriptionTextField.text = clothes.descriptions
//    turnEditMode(isOn: false)
  }
  
  private func turnEditMode(isOn: Bool) {
//    categotyPickerView.isUserInteractionEnabled = isOn
//    weatherSegmentedControl.isUserInteractionEnabled = isOn
//    descriptionTextField.isUserInteractionEnabled = isOn
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
    if isEditingStyle {
    }
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
    view.addSubview(colletionView)
    colletionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    colletionView.registerCell(cellClass: StyleDetailCell.self)
    colletionView.dataSource = self
    colletionView.contentInset = .init(top: 0, left: Metric.padding,
                                       bottom: 0, right: Metric.padding)
  }
  
}

// MARK: - UICollectionViewDataSource

extension StyleDetailController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return ClothesCategory.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(cellClass: StyleDetailCell.self, for: indexPath)
    
    if let category = ClothesCategory(rawValue: indexPath.row),
       case let .showDetail(style: style) = type,
       let clothes = style.clothes[category] {
      cell.configure(with: clothes)
    }
    return cell
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
    let vc = StyleDetailController(type: .showDetail(style: .mocks.first!))
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
