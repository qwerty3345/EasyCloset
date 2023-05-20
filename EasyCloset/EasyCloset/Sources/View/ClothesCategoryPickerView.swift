//
//  ClothesCategoryPicker.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

final class ClothesCategoryPickerView: UIPickerView {

  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  
  private func setup() {
    dataSource = self
    backgroundColor = .white.withAlphaComponent(0.5)
    layer.cornerRadius = 16
  }
}

// MARK: - UIPickerViewDelegate

extension ClothesCategoryPickerView: UIPickerViewDelegate {
  override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
    guard let category = ClothesCategory.allCases[safe: row] else { return }
    // TODO: 카테고리 선택 넘기기
  }
}

// MARK: - UIPickerViewDataSource

extension ClothesCategoryPickerView: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ClothesCategory.allCases.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ClothesCategory.allCases[safe: row]?.korean ?? ""
  }
  
}
