//
//  StyleDetailViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/26.
//

import Foundation

import Combine

final class StyleDetailViewModel {
  
  // MARK: - Properties
  
  @Published private(set) var styleToEdit: Style?
  
  let didSuccessToSave = PassthroughSubject<Void, Never>()
  let didFailToSave = PassthroughSubject<String, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: StyleRepositoryProtocol
  
  // MARK: - Initialization
  
  init(style: Style?, repository: StyleRepositoryProtocol) {
    self.styleToEdit = style
    self.repository = repository
  }
  
  // MARK: - Public Methods
  
  func save(name: String?, weather: WeatherType) {
    guard var style = styleToEdit else { return }
    style.name = name
    style.weather = weather
    
    repository.save(style: style)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          self?.didSuccessToSave.send()
        case .failure(let error):
          self?.didFailToSave.send(error.localizedDescription)
        }
      }, receiveValue: { })
      .store(in: &cancellables)
  }
  
  func update(clothes: Clothes, weather: WeatherType) {
    if styleToEdit == nil {
      styleToEdit = Style(clothes: [:], weather: weather)
    }
    styleToEdit?.clothes[clothes.category] = clothes
  }
  
  func removeClothes(of category: ClothesCategory) {
    styleToEdit?.clothes.removeValue(forKey: category)
  }
}
