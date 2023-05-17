//
//  MainTabBarController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

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
  
  // MARK: - Private Methods
  
}

// MARK: - UI & Layout

extension MainTabBarController {
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    view.backgroundColor = .systemBackground
  }
  
  private func setupLayout() {
    setupViewControllers()
  }
  
  private func setupViewControllers() {
    tabBar.tintColor = Color.accentColor
    
    let clothesController = navigationController(
      image: Icon.tshirt,
      selectedImage: Icon.tshirtSelected,
      viewController: ClothesController())
    
    let homeController = navigationController(
      image: Icon.house,
      selectedImage: Icon.houseSelected,
      viewController: HomeController())
    
    let styleController = navigationController(
      image: Icon.closet,
      selectedImage: Icon.closetSelected,
      viewController: StyleController())
    
    viewControllers = [clothesController, homeController, styleController]
  }
  
  private func navigationController(image: UIImage?,
                                    selectedImage: UIImage?,
                                    viewController: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.image = image
    navigationController.tabBarItem.selectedImage = selectedImage
    navigationController.navigationBar.tintColor = Color.accentColor
    return navigationController
  }
}
