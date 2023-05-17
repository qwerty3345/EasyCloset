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
//    tabBar.tintColor = appColor
    
    let clothesController = navigationController(
      unselectedImage: UIImage(systemName: "film.stack"),
      selectedImage: UIImage(systemName: "film.stack.fill"),
      viewController: ClothesController())
    
    let homeController = navigationController(
      unselectedImage: UIImage(systemName: "magnifyingglass"),
      selectedImage: UIImage(systemName: "magnifyingglass"),
      viewController: HomeController())
    
    let styleController = navigationController(
      unselectedImage: UIImage(systemName: "person.crop.circle"),
      selectedImage: UIImage(systemName: "person.crop.circle.fill"),
      viewController: StyleController())
    
    viewControllers = [clothesController, homeController, styleController]
  }
  
  private func navigationController(unselectedImage: UIImage?,
                                    selectedImage: UIImage?,
                                    viewController: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.image = unselectedImage
    navigationController.tabBarItem.selectedImage = selectedImage
    //    nav.navigationBar.tintColor =
    return navigationController
  }
}
