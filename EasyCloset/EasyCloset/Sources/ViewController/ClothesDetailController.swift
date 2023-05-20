//
//  ClothesDetailController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

import Then
import SnapKit

import Combine

final class ClothesDetailController: UIViewController {
  
  // MARK: - Properties
  
  private let type: ClothesDetailControllerType
  private var isEditingClothes = false {
    didSet {
      turnEditMode(isOn: isEditingClothes)
    }
  }
  private var isPhotoAdded = false {
    didSet {
      turnPhotoEditMode(isPhotoAdded: isPhotoAdded)
    }
  }
  
  private var cancellables = Set<AnyCancellable>()
  
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
  
  private lazy var cameraButton = AddPhotoButton(
    title: "카메라",
    image: UIImage(systemName: "camera.fill")).then {
      $0.addTarget(self, action: #selector(tappedCameraButton), for: .touchUpInside)
    }
  private lazy var galleryButton = AddPhotoButton(
    title: "사진첩",
    image: UIImage(systemName: "photo.fill")).then {
      $0.addTarget(self, action: #selector(tappedGalleryButton), for: .touchUpInside)
    }
  
  private lazy var addPhotoStackView = UIStackView(arrangedSubviews: [
    cameraButton, galleryButton
  ]).then {
    $0.axis = .horizontal
    $0.spacing = 20
  }
  
  private lazy var photoPicker = PhotoPicker(parent: self)
  
  private lazy var photoRemoveButton = UIButton().then {
    $0.setImage(UIImage(systemName: "trash"), for: .normal)
    $0.tintColor = .systemRed
    $0.isHidden = true
    $0.addTarget(self, action: #selector(didRemovePhoto), for: .valueChanged)
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
    
    clothesImageView.image = clothes.image
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
  
  private func turnPhotoEditMode(isPhotoAdded: Bool) {
    addPhotoStackView.isHidden = isPhotoAdded
    addPhotoLabel.isHidden = isPhotoAdded
    photoRemoveButton.isHidden = isPhotoAdded == false
    
    if isPhotoAdded == false {
      clothesImageView.image = nil
    }
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
    if isEditingClothes {
      isEditingClothes = false
      editAddBarButton.title = "편집"
    } else {
      isEditingClothes = true
      editAddBarButton.title = "완료"
    }
  }
  
  @objc private func didSelectWeather(_ sender: UISegmentedControl) {
    guard let weatherType = WeatherType(rawValue: sender.selectedSegmentIndex) else { return }
  }
  
  @objc private func tappedCameraButton() {
    photoPicker.requestCamera()
      .sink { completion in
        if case .failure(let error) = completion {
          // TODO: 실패 alert 띄우기
          print("실패..... \(error)")
        }
      } receiveValue: { [weak self] image in
        self?.clothesImageView.image = image
        self?.isPhotoAdded = true
      }
      .store(in: &cancellables)
  }
  
  @objc private func tappedGalleryButton() {
    photoPicker.requestAlbum()
      .sink { completion in
        if case .failure(let error) = completion {
          // TODO: 실패 alert 띄우기
          print("실패..... \(error)")
        }
      } receiveValue: { [weak self] image in
        self?.clothesImageView.image = image
        self?.isPhotoAdded = true
      }
      .store(in: &cancellables)
  }
  
  @objc private func didRemovePhoto() {
    isPhotoAdded = false
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
    setupclothesImageViewLayout()
    setupSection(with: "카테고리", view: categotyPickerView, viewHeight: 100, spacing: 16)
    setupSection(with: "계절", view: weatherSegmentedControl, viewHeight: 30, spacing: 40)
    setupSection(with: "설명", view: descriptionTextField, spacing: 16)
    
    if type == .add {
      setupAddPhotoButtonsLayout()
    }
    setupPhotoRemoveButtonLayout()
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
  
  private func setupAddPhotoButtonsLayout() {
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
  
  private func setupPhotoRemoveButtonLayout() {
    view.addSubview(photoRemoveButton)
    photoRemoveButton.snp.makeConstraints {
      $0.bottom.equalTo(clothesImageView.snp.bottom)
      $0.centerX.equalTo(addPhotoStackView)
      $0.height.width.equalTo(80)
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
