//
//  MainTabBarController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

enum TabBarIndex: Int {
  case clothes
  case home
  case style
}

final class MainTabBarController: UITabBarController {
  
  // MARK: - Constants
  
  private enum Metric { }
  
  // MARK: - Properties
  
  // MARK: - UI Components
  
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Public Methods
  
  func moveWithAnimation(to index: TabBarIndex) {
    moveWithAnimation(to: index.rawValue)
  }
  
  // MARK: - Private Methods
  
}

// MARK: - UI & Layout

extension MainTabBarController {
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    setupViewControllers()
  }
  
  private func setupViewControllers() {
    tabBar.tintColor = .accentColor
    
    let clothesController = navigationController(
      image: .tshirt,
      selectedImage: .tshirtSelected,
      title: "옷",
      viewController: ClothesController(viewModel: ClothesViewModel()))
    
    let homeController = navigationController(
      image: .house,
      selectedImage: .houseSelected,
      title: "홈",
      viewController: HomeController())
    
    let styleController = navigationController(
      image: .closet,
      selectedImage: .closetSelected,
      title: "스타일",
      viewController: StyleController())
    
    viewControllers = [clothesController, homeController, styleController]
    selectedIndex = TabBarIndex.home.rawValue
  }
  
  private func navigationController(image: UIImage?,
                                    selectedImage: UIImage?,
                                    title: String,
                                    viewController: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.image = image
    navigationController.tabBarItem.selectedImage = selectedImage
    navigationController.tabBarItem.title = title
    navigationController.navigationBar.tintColor = .accentColor
    return navigationController
  }
}
