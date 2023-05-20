//
//  ClothesDetailController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

final class ClothesDetailController: UIViewController {
  
  enum ControllerType {
    case add
    case showDetail
  }
  
  // MARK: - Properties
  
  private let type: ControllerType
  
  // MARK: - UI Components
  
  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    $0.isLayoutMarginsRelativeArrangement = true
  }
  
  private let clothesImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .white
  }
  
  private let addPhotoLabel = UILabel().then {
    $0.text = "사진 등록하기"
    $0.font = .pretendardLargeTitle
  }
  
  private let cameraButton = AddPhotoButton(
    title: "카메라",
    image: UIImage(systemName: "camera.fill"))
  private let galleryButton = AddPhotoButton(
    title: "사진첩",
    image: UIImage(systemName: "photo.fill"))
  private lazy var addPhotoStackView = UIStackView(arrangedSubviews: [
    cameraButton, galleryButton
  ]).then {
    $0.axis = .horizontal
    $0.spacing = 20
  }
  
  private let categotyPickerView = ClothesCategoryPickerView()
  
  private lazy var weatherSegmentedControl = UISegmentedControl(
    items: WeatherType.allCases.map { $0.korean }
  ).then {
    $0.addTarget(self, action: #selector(didSelectWeather), for: .valueChanged)
  }
  
  private let descriptionTextField = UITextField().then {
    $0.placeholder = "설명을 입력해주세요 (선택)"
  }
  
  // MARK: - Initialization
  
  init(type: ControllerType) {
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
    
    categotyPickerView.selectRow(clothes.category.rawValue,
                                 inComponent: 0, animated: false)
    clothesImageView.image = clothes.image
    if let weatherType = clothes.weatherType {
      weatherSegmentedControl.selectedSegmentIndex = weatherType.rawValue
    }
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
  
  @objc private func didSelectWeather(_ sender: UISegmentedControl) {
    guard let weatherType = WeatherType(rawValue: sender.selectedSegmentIndex) else { return }
  }
}

// MARK: - UI & Layout

extension ClothesDetailController {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    switch type {
    case .add:
      title = "옷 추가하기"
    case .showDetail:
      title = "옷 상세보기"
    }
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    setupScrollViewLayout()
    setupclothesImageViewLayout()
    setupSection(with: "카테고리", view: categotyPickerView, viewHeight: 100, spacing: 16)
    setupSection(with: "계절", view: weatherSegmentedControl, viewHeight: 30, spacing: 40)
    setupSection(with: "설명", view: descriptionTextField, spacing: 16)
    
    if type == .add {
      setupAddPhotoButtons()
    }
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
  
  private func setupclothesImageViewLayout() {
    contentStackView.addArrangedSubview(clothesImageView)
    contentStackView.setCustomSpacing(30, after: clothesImageView)
    clothesImageView.snp.makeConstraints {
      $0.width.equalTo(clothesImageView.snp.height)
    }
  }
  
  private func setupAddPhotoButtons() {
    [cameraButton, galleryButton].forEach { button in
      button.snp.makeConstraints {
        $0.width.equalTo(80)
        $0.height.equalTo(90)
      }
    }
    view.addSubview(addPhotoStackView)
    addPhotoStackView.snp.makeConstraints {
      $0.center.equalTo(clothesImageView)
    }
    
    view.addSubview(addPhotoLabel)
    addPhotoLabel.snp.makeConstraints {
      $0.bottom.equalTo(addPhotoStackView.snp.top).inset(-20)
      $0.centerX.equalTo(addPhotoStackView)
    }
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

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ClothesDetailControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = ClothesDetailController(type: .showDetail)
    vc.configure(with: Clothes.mock)
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
