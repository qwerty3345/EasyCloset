//
//  HomeController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import SnapKit
import Then

final class HomeController: UIViewController {
  
  // MARK: - UI Components
  
  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 16
    $0.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    $0.isLayoutMarginsRelativeArrangement = true
  }
  
  private lazy var styleInfoView = InfoView(with: "스타일으로 이동하기", image: .styleInfo).then {
    $0.addTarget(self, action: #selector(tappedStyleInfoView), for: .touchUpInside)
  }
  private lazy var clothesInfoView = InfoView(with: "옷장으로 이동하기", image: .clothesInfo).then {
    $0.addTarget(self, action: #selector(tappedClothesInfoView), for: .touchUpInside)
  }
  
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Public Methods
  
  // MARK: - Private Methods
  
  @objc private func tappedClothesInfoView() {
    guard let tabBar = tabBarController as? MainTabBarController else { return }
    tabBar.moveWithAnimation(to: .clothes)
  }
  
  @objc private func tappedStyleInfoView() {
    guard let tabBar = tabBarController as? MainTabBarController else { return }
    tabBar.moveWithAnimation(to: .style)
  }
}

// MARK: - UI & Layout

extension HomeController {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    addLeftTitle(with: "HOME")
    [clothesInfoView, styleInfoView].forEach {
      $0.addShadow(to: .bottom)
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
    
    [clothesInfoView, styleInfoView].forEach {
      contentStackView.addArrangedSubview($0)
      $0.snp.makeConstraints { make in
        make.height.equalTo(250)
      }
    }
    
  }
}
