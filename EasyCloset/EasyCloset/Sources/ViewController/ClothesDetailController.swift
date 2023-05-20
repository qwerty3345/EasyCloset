//
//  ClothesDetailController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

import Then
import SnapKit

final class ClothesDetailController: UIViewController {
  
  // MARK: - Properties
  
  private let type: ClothesDetailControllerType
  
  private var isEditingClothes = false {
    didSet {
      turnEditMode(isOn: isEditingClothes)
    }
  }
  
  private lazy var photoPicker = PhotoPicker(parent: self)
  
  // MARK: - UI Components
  
  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    $0.isLayoutMarginsRelativeArrangement = true
  }
  
  private lazy var photoHandlingView = PhotoHandlingView(with: photoPicker)
  
  private let categotyPickerView = ClothesCategoryPickerView()
  
  private lazy var weatherSegmentedControl = UISegmentedControl(
    items: WeatherType.allCases.map { $0.korean }
  )
  
  private let descriptionTextField = UITextField().then {
    $0.placeholder = "설명을 입력해주세요 (선택)"
  }
  
  private lazy var editAddBarButton = UIBarButtonItem(
    title: type.rightBarButtonTitle,
    style: .plain,
    target: self,
    action: #selector(tappedEditAddButton))
  
  // MARK: - Initialization
  
  init(type: ClothesDetailControllerType) {
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
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    descriptionTextField.resignFirstResponder()
  }
  
  // MARK: - Public Methods
  
  func configure(with clothes: Clothes) {
    guard type == .showDetail else { return }
    
    photoHandlingView.setImage(clothes.image)
    categotyPickerView.selectRow(clothes.category.rawValue,
                                 inComponent: 0, animated: false)
    weatherSegmentedControl.selectedSegmentIndex = clothes.weatherType.rawValue
    if let description = clothes.description {
      descriptionTextField.text = description
    }
    turnEditMode(isOn: false)
  }
  
  // MARK: - Private Methods
  
  private func turnEditMode(isOn: Bool) {
    categotyPickerView.isUserInteractionEnabled = isOn
    weatherSegmentedControl.isUserInteractionEnabled = isOn
    descriptionTextField.isUserInteractionEnabled = isOn
  }
  
  @objc private func tappedEditAddButton() {
    switch type {
    case .add:
      addClothes()
    case .showDetail:
      editClothes()
    }
  }
  
  private func addClothes() {
    navigationController?.popViewController(animated: true)
  }
  
  private func editClothes() {
    isEditingClothes.toggle()
    editAddBarButton.title = isEditingClothes ? "완료" : "편집"
    photoHandlingView.state = isEditingClothes ? .editing : .show
  }
}

// MARK: - UI & Layout

extension ClothesDetailController {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    title = type.title
    navigationItem.rightBarButtonItem = editAddBarButton
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    setupScrollViewLayout()
//    setupclothesImageViewLayout()
    setupAddPhotoViewLayout()
    setupSection(with: "카테고리", view: categotyPickerView, viewHeight: 100, spacing: 16)
    setupSection(with: "계절", view: weatherSegmentedControl, viewHeight: 30, spacing: 40)
    setupSection(with: "설명", view: descriptionTextField, spacing: 16)
    
//    if type == .add {
//      setupAddPhotoButtonsLayout()
//    }
//    setupPhotoRemoveButtonLayout()
  }
  
  private func setupScrollViewLayout() {
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    scrollView.addSubview(contentStackView)
    contentStackView.snp.makeConstraints {
      $0.edges.width.equalToSuperview()
    }
  }
  
  private func setupAddPhotoViewLayout() {
    contentStackView.addArrangedSubview(photoHandlingView)
    contentStackView.setCustomSpacing(30, after: photoHandlingView)
  }
  
  private func setupSection(with title: String, view: UIView,
                            viewHeight: CGFloat? = nil, spacing: CGFloat) {
    addHeaderLabel(with: title)
    contentStackView.addArrangedSubview(view)
    contentStackView.setCustomSpacing(spacing, after: view)
    guard let height = viewHeight else { return }
    view.snp.makeConstraints {
      $0.height.equalTo(height)
    }
  }
  
  private func addHeaderLabel(with title: String) {
    contentStackView.addArrangedSubview(.seperatorView)
    let label = UILabel().then { label in
      label.text = title
      label.font = .pretendardMediumTitle
      label.snp.makeConstraints {
        $0.height.equalTo(60)
      }
    }
    contentStackView.addArrangedSubview(label)
  }
}

// MARK: - ClothesDetailControllerType

enum ClothesDetailControllerType {
  case add
  case showDetail
  
  var title: String {
    switch self {
    case .add:
      return "옷 추가하기"
    case .showDetail:
      return "옷 상세보기"
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

struct ClothesDetailControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = ClothesDetailController(type: .add)
    vc.configure(with: Clothes.mock)
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
