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
    delegate = self
    backgroundColor = .white.withAlphaComponent(0.5)
    layer.cornerRadius = 16
  }
}

// MARK: - UIPickerViewDelegate

extension ClothesCategoryPickerView: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                  forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = (view as? UILabel) ?? UILabel()
    label.font = .pretendardContent
    label.textAlignment = .center
    label.text = ClothesCategory.allCases[safe: row]?.korean ?? ""
    return label
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
}
