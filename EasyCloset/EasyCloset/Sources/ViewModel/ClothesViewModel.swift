//
//  ClothesViewModel.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/19.
//

import Foundation

import Combine

final class ClothesViewModel {
  
  // MARK: - Properties
  
  @Published private var clothesList = ClothesList(clothesByCategory: [:])
  
  let searchFilters = CurrentValueSubject<FilterItems, Never>([])
  let clothesListDidUpdate = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let clothesStorage: ClothesStorageProtocol
  private let imageFileStorage: ImageFileStorageProtocol
  
  // MARK: - Initialization
  
  // 1초 후에 로딩 되는 것을 테스트 함
  init(clothesStorage: ClothesStorageProtocol = ClothesStorage.shared,
       imageFileStorage: ImageFileStorageProtocol = ImageFileStorage.shared) {
    self.clothesStorage = clothesStorage
    self.imageFileStorage = imageFileStorage
    bind()
  }
  
  // MARK: - Public Methods
  
  func clothes(of category: ClothesCategory) -> AnyPublisher<[Clothes], Never> {
    $clothesList
      .map { $0.clothesByCategory[category] ?? [] }
      .combineLatest(searchFilters)
      .map(applyFilters)
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    clothesStorage.fetchClothesList()
      .sink { completion in
        if case let .failure(error) = completion {
          print(error)
        }
      } receiveValue: { clothesList in
        self.clothesList = clothesList
      }
      .store(in: &cancellables)
    
    clothesListDidUpdate
      .flatMap { [weak self] in
        guard let self = self else { return Empty<ClothesList, StorageError>().eraseToAnyPublisher() }
        return self.clothesStorage.fetchClothesList()
      }
      .sink { completion in
        if case let .failure(error) = completion {
          print(error)
        }
      } receiveValue: { [weak self] clothesList in
        self?.clothesList = clothesList
      }
      .store(in: &cancellables)
  }
    
  private func applyFilters(clothesList: [Clothes], filters: FilterItems) -> [Clothes] {
    return filters.reduce(clothesList) { currentList, filter in
      switch filter {
      case .sort(let sort):
        return applySort(filter: sort, to: currentList)
      case .weather(let weather):
        return applyWeather(filter: weather, to: currentList)
      case .clothes(let clothes):
        return applyClothes(filter: clothes, to: currentList)
      }
    }
  }
  
  private func applySort(filter: SortBy, to clothesList: [Clothes]) -> [Clothes] {
    switch filter {
    case .new:
      return clothesList.sorted { $0.createdAt > $1.createdAt }
    case .old:
      return clothesList.sorted { $0.createdAt < $1.createdAt }
    }
  }
  
  private func applyWeather(filter: WeatherType, to clothesList: [Clothes]) -> [Clothes] {
    return clothesList.filter { $0.weatherType == filter }
  }
  
  private func applyClothes(filter: ClothesCategory, to clothesList: [Clothes]) -> [Clothes] {
    return clothesList.filter { $0.category == filter }
  }
}
