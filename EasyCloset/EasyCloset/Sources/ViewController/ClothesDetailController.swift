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
  
  // MARK: - Constants
  
  private enum Metric { }
  
  // MARK: - Properties
  
  private let type: ControllerType
  
  // MARK: - UI Components
  
  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 16
    $0.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    $0.isLayoutMarginsRelativeArrangement = true
  }
  
  private let clothesImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .white
  }
  
  private let addPhotoLabel = UILabel().then {
    $0.text = "사진 등록하기"
    $0.font = .pretendardMediumTitle
  }
  
  private let cameraButton = UIButton()
  private let galleryButton = UIButton()
  private lazy var addPhotoStackView = UIStackView(arrangedSubviews: [
    cameraButton, galleryButton
  ]).then {
    $0.axis = .horizontal
    $0.spacing = 20
  }
  
  private let categotyPickerView = ClothesCategoryPickerView()
  
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
  
  // MARK: - Public Methods
  
  func configure(with clothes: Clothes) {
    guard type == .showDetail else { return }
  }
  
  // MARK: - Private Methods
  
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
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    scrollView.addSubview(contentStackView)
    contentStackView.snp.makeConstraints {
      $0.edges.width.equalToSuperview()
    }
    
    contentStackView.addArrangedSubview(clothesImageView)
    clothesImageView.snp.makeConstraints {
      $0.width.equalTo(clothesImageView.snp.height)
    }
    
    contentStackView.addArrangedSubview(headerLabel(with: "카테고리"))
    contentStackView.addArrangedSubview(categotyPickerView)
    categotyPickerView.snp.makeConstraints {
      $0.height.equalTo(100)
    }
    
    contentStackView.addArrangedSubview(headerLabel(with: "계절"))
  }
  
  private func headerLabel(with title: String) -> UILabel {
    let label = UILabel()
    label.text = title
    label.font = .pretendardMediumTitle
    label.snp.makeConstraints {
      $0.height.equalTo(60)
    }
    label.backgroundColor = .lightGray
    return label
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ClothesDetailControllerPreview: PreviewProvider {
  static var previews: some View {
    UINavigationController(
      rootViewController: ClothesDetailController(type: .add)
    ).toPreview()
  }
}
#endif
