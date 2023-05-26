//
//  MainTabBarController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

enum TabBarItems: Int {
  case clothes
  case home
  case style
}

final class MainTabBarController: UITabBarController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Public Methods
  
  func moveWithAnimation(to index: TabBarItems) {
    moveWithAnimation(to: index.rawValue)
  }
}

// MARK: - UI & Layout

extension MainTabBarController {
  private func setup() {
    setUI()
    setupViewControllers()
    setupGestures()
    delegate = self
  }
  
  private func setUI() {
    view.backgroundColor = .background
    tabBar.tintColor = .accentColor
  }
  
  private func setupViewControllers() {
    let clothesController = navigationController(
      image: .tshirt,
      selectedImage: .tshirtSelected,
      title: "옷",
      viewController: DIContainer.shared.makeClothesController())
    
    let homeController = navigationController(
      image: .house,
      selectedImage: .houseSelected,
      title: "홈",
      viewController: HomeController())
    
    let styleController = navigationController(
      image: .closet,
      selectedImage: .closetSelected,
      title: "스타일",
      viewController: DIContainer.shared.makeStyleController())
    
    viewControllers = [clothesController, homeController, styleController]
    selectedIndex = TabBarItems.home.rawValue
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
  
  private func setupGestures() {
    let swipeRightGesture = UISwipeGestureRecognizer(
      target: self,
      action: #selector(handleSwipeGesture))
    swipeRightGesture.direction = .right
    view.addGestureRecognizer(swipeRightGesture)
    
    let swipeLeftGesture = UISwipeGestureRecognizer(
      target: self,
      action: #selector(handleSwipeGesture))
    swipeLeftGesture.direction = .left
    view.addGestureRecognizer(swipeLeftGesture)
  }
  
  @objc private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
    var destinationIndex = selectedIndex
    switch sender.direction {
    case .left:
      destinationIndex += 1
    case .right:
      destinationIndex -= 1
    default:
      break
    }
    moveWithAnimation(to: destinationIndex)
  }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController,
                        shouldSelect viewController: UIViewController) -> Bool {
    moveWithAnimation(to: viewController)
    return false
  }
}
