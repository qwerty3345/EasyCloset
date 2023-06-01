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
  
  // repository에서 가져온 모델 객체
  @Published private var clothesList = ClothesList(clothesByCategory: [:])
  
  // 필터가 적용된 clothesList를 뷰컨에서 바인딩
  var filteredClothesList: AnyPublisher<ClothesList, Never> {
    $clothesList
      .combineLatest(searchFilters)
      .map(applyFilters)
      .eraseToAnyPublisher()
  }
  
  let searchFilters = CurrentValueSubject<FilterItems, Never>([.sort(.new)])
  let deleteClothes = PassthroughSubject<Clothes, Never>()
  let clothesListDidUpdate = PassthroughSubject<Void, Never>()
  let clothesListDidEndUpdate = PassthroughSubject<Void, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let repository: ClothesRepositoryProtocol
  
  // MARK: - Initialization
  
  init(repository: ClothesRepositoryProtocol) {
    self.repository = repository
    bind()
  }
  
  // MARK: - Public Methods
  
  func clothes(of category: ClothesCategory) -> AnyPublisher<[Clothes], Never> {
    $clothesList
      .map { $0.clothesByCategory[category] ?? [] }
      .eraseToAnyPublisher()
  }

  // MARK: - Private Methods
  
  private func bind() {
    clothesListDidUpdate
      .prepend(()) // 초기에 값을 한 번 발행
      .flatMap { [weak self] in
        guard let self = self else { return Empty<ClothesList, RepositoryError>().eraseToAnyPublisher() }
        return self.repository.fetchClothesList()
      }
      .sink { completion in
        if case let .failure(error) = completion {
          // TODO: 에러 처리
          print(error)
        }
      } receiveValue: { [weak self] clothesList in
        self?.clothesList = clothesList
        self?.clothesListDidEndUpdate.send()
      }
      .store(in: &cancellables)
    
    deleteClothes
      .sink { [weak self] clothes in
        self?.repository.remove(clothes: clothes)
        self?.clothesListDidUpdate.send()
      }
      .store(in: &cancellables)
  }
  
  private func applyFilters(to clothesList: ClothesList, filters: FilterItems) -> ClothesList {
    let filteredClothesByCategory = clothesList.clothesByCategory.mapValues { clothesArray in
      filters.reduce(clothesArray) { clothesArray, filter in
        switch filter {
        case .sort(let sort):
          return applySort(filter: sort, to: clothesArray)
        case .weather(let weather):
          return applyWeather(filter: weather, to: clothesArray)
        case .clothes(let clothes):
          return applyClothes(filter: clothes, to: clothesArray)
        }
      }
    }
    return ClothesList(clothesByCategory: filteredClothesByCategory)
  }
  
  private func applySort(filter: SortBy, to clothesArray: [Clothes]) -> [Clothes] {
    switch filter {
    case .new:
      return clothesArray.sorted { $0.createdAt > $1.createdAt }
    case .old:
      return clothesArray.sorted { $0.createdAt < $1.createdAt }
    }
  }
  
  private func applyWeather(filter: WeatherType, to clothesArray: [Clothes]) -> [Clothes] {
    return clothesArray.filter { $0.weatherType == filter }
  }
  
  private func applyClothes(filter: ClothesCategory, to clothesArray: [Clothes]) -> [Clothes] {
    return clothesArray.filter { $0.category == filter }
  }
}
