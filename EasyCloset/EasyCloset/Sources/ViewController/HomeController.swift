//
//  HomeController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

final class HomeController: UIViewController {
  
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

extension HomeController {
  
  private func setup() {
    setUI()
    setupLayout()
  }
  
  private func setUI() {
    navigationItem.title = "HOME"
  }
  
  private func setupLayout() { }
}

