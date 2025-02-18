//
//  ClothesViewModelTests.swift
//  EasyClosetTests
//
//  Created by Mason Kim on 2023/05/28.
//
// swiftlint:disable all

import XCTest
import Combine
@testable import EasyCloset

final class ClothesViewModelTests: XCTestCase {
  
  var sut: ClothesViewModel!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    let mockRepository = MockClothesRepository()
    sut = ClothesViewModel(repository: mockRepository)
    cancellables = []
  }
  
  override func tearDownWithError() throws {
    sut = nil
    cancellables = nil
  }
  
  func test_clothes가_특정_카테고리의_clothes만_내보내는지_테스트() {
    // given
    let expectation = XCTestExpectation()
    let category = ClothesCategory.accessory
    
    // when
    sut.clothes(of: category)
      .sink { clothes in
        // then
        XCTAssertTrue(clothes.allSatisfy {
          $0.category == category
        })
        expectation.fulfill()
      }
      .store(in: &cancellables)
  }
  
  func test_최신순_filter가_적용되는지_테스트() {
    // given
    sut.searchFilters.send([.sort(.new)])
    let expectation = XCTestExpectation()
    
    // when
    sut.filteredClothesList
      .sink { clothesList in
        clothesList.clothesByCategory.forEach { category, clothes in
          let sortedClothes = clothes.sorted(by: { $0.createdAt > $1.createdAt })
          // then
          XCTAssertEqual(clothes, sortedClothes)
        }
        expectation.fulfill()
      }
      .store(in: &cancellables)
  }
  
  func test_계절_filter가_적용되는지_테스트() {
    // given
    let weatherFilterType: WeatherType = .fall
    sut.searchFilters.send([.weather(weatherFilterType)])
    let expectation = XCTestExpectation()
    
    // when
    sut.filteredClothesList
      .sink { clothesList in
        clothesList.clothesByCategory.forEach { category, clothes in
          XCTAssertTrue(clothes.allSatisfy {
            $0.weatherType == weatherFilterType
          })
        }
        expectation.fulfill()
      }
      .store(in: &cancellables)
  }

}
