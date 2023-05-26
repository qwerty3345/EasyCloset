//
//  DIContainer.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/27.
//

import Foundation

final class DIContainer {
  
  // MARK: - SingleTon
  
  static let shared = DIContainer()
  private init() {}
  
  // MARK: - Properties
  
  private let realmStorage: RealmStorageProtocol = RealmStorage()
  private let imageFileStorage: ImageFileStorageProtocol = ImageFileStorage()
  
  private lazy var clothesRepository: ClothesRepositoryProtocol = ClothesRepository(
    realmStorage: realmStorage,
    imageFileStorage: imageFileStorage)
  private lazy var styleRepository: StyleRepositoryProtocol = StyleRepository(
    realmStorage: realmStorage,
    imageFileStorage: imageFileStorage)
  
  // MARK: - DI Factory Methods
  
  /// Clothes 관련 컨트롤러 팩토리
  func makeClothesController() -> ClothesController {
    let viewModel = ClothesViewModel(repository: clothesRepository)
    return ClothesController(viewModel: viewModel)
  }
  
  func makeClothesDetailController(type: ClothesDetailControllerType) -> ClothesDetailController {
    let viewModel: ClothesDetailViewModel = {
      switch type {
      case .add:
        return ClothesDetailViewModel(clothes: nil, repository: clothesRepository)
      case .showDetail(let clothes):
        return ClothesDetailViewModel(clothes: clothes, repository: clothesRepository)
      }
    }()
    
    return ClothesDetailController(type: type, viewModel: viewModel)
  }
  
  func makeClothesFilterController() -> ClothesFilterController {
    let viewModel = ClothesViewModel(repository: clothesRepository)
    return ClothesFilterController(viewModel: viewModel)
  }
  
  /// Style 관련 컨트롤러 팩토리
  func makeStyleController() -> StyleController {
    let viewModel = StyleViewModel(repository: styleRepository)
    return StyleController(viewModel: viewModel)
  }
  
  func makeStyleDetailController(type: StyleDetailControllerType) -> StyleDetailController {
    let viewModel: StyleDetailViewModel = {
      switch type {
      case .add:
        return StyleDetailViewModel(style: nil, repository: styleRepository)
      case .showDetail(let style):
        return StyleDetailViewModel(style: style, repository: styleRepository)
      }
    }()
    
    return StyleDetailController(type: type, viewModel: viewModel)
  }
  
  func makeStyleAddClothesController(category: ClothesCategory) -> StyleAddClothesController {
    // TODO: ClotheViewModel을 공유하니, dictionary형태로 resolve 할 수 있게 구현하기
    let viewModel = ClothesViewModel(repository: clothesRepository)
    return StyleAddClothesController(category: category, viewModel: viewModel)
  }
}
