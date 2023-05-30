<p align="center"><img src="https://github.com/qwerty3345/ios-closet-app/assets/59835351/f178579f-666d-48eb-b356-ea4e9bd8600b"></p>

> 🏃🏻🏃🏻‍♂️💨 프로젝트 기간: 23.05.17 ~ 23.05.29 (약 2주)

## ⚙️ Framework / Architecture

- UIKit (Code base)
- Combine
- MVVM

![image](https://github.com/qwerty3345/ios-closet-app/assets/59835351/beff5976-13e0-45d4-9769-3812d3814317)


### 📂 프로젝트 폴더링
<details>
<summary>폴더링 구조</summary>

```
├── Application
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── DIContainer.swift
├── Data
│   ├── Model
│   │   ├── ClothesEntity.swift
│   │   ├── CoreDataModels.xcdatamodeld
│   │   │   └── CoreDataModels.xcdatamodel
│   │   │       └── contents
│   │   └── StyleEntity.swift
│   ├── Repository
│   │   ├── Common
│   │   │   ├── ImageFetchableRepository.swift
│   │   │   └── RepositoryError.swift
│   │   ├── StyleRepository.swift
│   │   └── ClothesRepository.swift
│   └── Storage
│       ├── ImageFileStorage.swift
│       └── RealmStorage.swift
├── Model
│   ├── Protocol
│   │   └── ImagableModel.swift
│   ├── Clothes.swift
│   ├── ClothesCategory.swift
│   ├── ClothesList.swift
│   ├── SortBy.swift
│   ├── Style.swift
│   └── WeatherType.swift
├── Utils
│   ├── Extensions
│   ├── HapticManager.swift
│   ├── ImageCacheManager.swift
│   └── PhotoPicker.swift
├── View
│   ├── Protocol
│   │   ├── Highlightable.swift
│   │   ├── ReusableView.swift
│   │   └── ShadowableCellType.swift
│   ├── Clothes
│   │   ├── AddClothesCell.swift
│   │   ├── CarouselFlowLayout.swift
│   │   ├── ClothesCarouselCell.swift
│   │   ├── ClothesCategoryHeaderView.swift
│   │   ├── ClothesCell.swift
│   │   ├── ClothesDetail
│   │   │   ├── AddPhotoButton.swift
│   │   │   ├── ClothesCategoryPickerView.swift
│   │   │   └── PhotoHandlingView.swift
│   │   └── Filter
│   │       ├── FilterCell.swift
│   │       └── FilterTitleHeaderView.swift
│   ├── Home
│   │   └── InfoView.swift
│   └── Style
│       ├── StyleAddClothesCell.swift
│       ├── StyleCell.swift
│       └── StyleDetailCell.swift
├── ViewController
│   ├── MainTabBarController.swift
│   ├── HomeController.swift
│   ├── Clothes
│   │   ├── ClothesController.swift
│   │   ├── ClothesDetailController.swift
│   │   └── ClothesFilterController.swift
│   └── Style
│       ├── StyleAddClothesController.swift
│       ├── StyleController.swift
│       └── StyleDetailController.swift
└── ViewModel
    ├── ClothesDetailViewModel.swift
    ├── ClothesViewModel.swift
    ├── StyleDetailViewModel.swift
    └── StyleViewModel.swift
```
</details>

## 📚 Library

> 의존성 관리 도구: `Swift Package Manager`
> 

| 이름 | 용도 |
| --- | --- |
| Snapkit | Auto Layout |
| Then | Syntax Sugar |
| RealmSwift | Local Storage |

<details>
<summary>각 라이브러리의 사용 이유</summary>
  
### 🫰 Snapkit

- Code UI 구현 시 중복된 코드를 줄이고 더 명시적으로 레이아웃을 잡기 위해 사용하였습니다.

### ✨ Then

- 주로 UI Component를 초기화할 때 작성하는 즉시 실행 클로저의 보일러플레이트를 줄이기 위해 사용하였습니다.

```swift
// 이런 형태의 클로저 즉시 실행 코드를
let label1: UILabel = {
  let label = UILabel()
  label.text = "레이블"
  return label
}()

// 이렇게 간단히 작성할 수 있었습니다.
let label2 = UILabel().then {
  $0.text = "레이블"
}
```

### 💽 RealmSwift

- 로컬 저장을 위해 사용하였습니다.
- 비교적 간단한 코드로 구현, 유지보수 할 수 있다는 장점과, 
  SQLite, CoreData와 비교해서 속도가 빠르다는 장점이 있어 선택하였습니다.
![realm](https://github.com/qwerty3345/ios-closet-app/assets/59835351/6a1a658f-695b-4151-9891-c10d7d168853)

- 단점: 하나의 스레드에서 작업해야 합니다. (충돌이 발생할 수 있습니다.)
</details>
  
## 📱 동작 화면

<details>
<summary>Screenshot 보기</summary>

> 초기 실행

![초기실행_홈화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/815b7671-eeb3-4ee6-ba39-89f32a8287c5)

> 옷 목록 - 사용자가 저장한 옷들을 가져와서 Carousel형태로 보여줍니다.

![옷_목록_화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/3059c254-e3f8-4abf-8c12-b6dac2c2014f)

> 옷 필터 검색 - 정렬/카테고리 등 필터를 적용해서 검색할 수 있습니다.

![옷_필터검색_화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/0ba0413c-f6d9-4764-8f13-f8c8385a71d2)

> 옷 상세보기/편집 - 옷 정보를 자세히 조회하거나 편집 / 추가 할 수 있습니다.

![옷_상세보기_추가_화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/bfe359bf-d1d9-4280-a069-512f01341b25)

> 옷 추가 카메라 권한 - 옷 추가 시 카메라를 선택하면 유저에게 카메라 권한을 요청하고, 권한이 없으면 설정 화면으로 이동하게 유도합니다.

![옷_추가_카메라_권한](https://github.com/qwerty3345/ios-closet-app/assets/59835351/e05b7868-d8d1-4077-9ed4-c7c87d98b2f3)

> 스타일 목록 - 사용자가 저장한 스타일을 가져와서 보여줍니다.

![스타일_목록_화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/0e643e6d-bfec-4266-bd37-00dc7e869257)

> 스타일 상세보기/편집 - 각 카테고리의 옷을 스타일에 편집 / 추가 할 수 있습니다.

![스타일_상세_화면](https://github.com/qwerty3345/ios-closet-app/assets/59835351/258cef4c-68c1-4756-a962-5db2b50a15ea)

> 삭제 기능 (메뉴) - 옷과 스타일을 각각 꾹 눌러서 삭제할 수 있습니다.

![삭제_기능](https://github.com/qwerty3345/ios-closet-app/assets/59835351/d12484ac-063a-4f70-ac06-e8668ba1aa67)

</details>


# 🔥 트러블 슈팅 / 기술적 도전

## 🎠 Carousel 뷰 구현

<details>
<summary>CollectionView 가로 스크롤을 할 때 사이즈가 동적으로 움직이게 구현</summary>

### 배경
    
> 이런 형태의 Carousel View를 구현해야 했음
> ![image](https://github.com/qwerty3345/ios-closet-app/assets/59835351/4c468ca4-a24c-4a5c-b6d9-8444dabf5f90)

- 초기엔 컬렉션뷰의 컴포지셔널 레이아웃으로 구성하였으나, 특정 셀의 크기를 키우며 자연스럽게 애니메이션을 주는 커스텀을 하기가 쉽지 않았음.
    - orthogonal 방식으로 툭툭 다음으로 넘어가게 구현하는 것은 쉬웠지만, 사용자의 스크롤에 따라 사이즈를 자연스럽게 키우고 줄이는 형태의 구현이 쉽지 않았음. 
    > CompositionalLayout에서 `contentOffset`와, 사이즈를 조절할 중앙에 있는 `cell`을 정확히 가져오는 것을 실패함. 
    
### 1차 구현
- FlowLayout을 커스텀해서 사용하기로 결정. Library 를 해체해보면서 필요한 부분만 뽑아서 따로 CarouselFlowLayout이라는 Custom Class 를 만듬
    - [UPCarouselFlowLayout](https://github.com/zepojo/UPCarouselFlowLayout) 을 참고
- 전체의 틀을 보면 각 상의/하의/… 의 섹션의 가로 스크롤 형태가 반복 되기에 컬렉션뷰의 셀로 구성하고
해당 셀 내부에 가로로 Carousel 레이아웃의 컬렉션뷰가 들어가 있는 중첩 컬렉션뷰의 형태
![EasyCloset 관련 001](https://github.com/qwerty3345/ios-closet-app/assets/59835351/3f650c9a-3218-4388-981d-9ee426fcaaec)

<details>
<summary>CaroselFlowLayout 코드</summary>
    
```swift
final class CarouselFlowLayout: UICollectionViewFlowLayout {
  
  private var sideItemScale: CGFloat = 0.6
  private var spacing: CGFloat = 40
  
  // collectionView의 크기
  private var size: CGSize = .zero
  
  // 처음 컬렉션 뷰가 나타날 때 호출되거나 레이아웃을 명시적 혹은 암묵적으로 무효화했을 때 호출
  override func prepare() {
    super.prepare()

    let currentSize = collectionView?.bounds.size ?? .zero
    if currentSize != size {
      self.setupCollectionView()
      self.updateLayout()
      self.size = currentSize
    }
  }
  
  private func setupCollectionView() {
    guard let collectionView = collectionView else { return }
    // 컬렉션뷰의 스크롤 감속 속도를 설정
    if collectionView.decelerationRate != .fast {
      collectionView.decelerationRate = .fast
    }
  }
  
  private func updateLayout() {
    guard let collectionView = collectionView else { return }
    
    let collectionSize = collectionView.bounds.size
    
    let horizontalInset = (collectionSize.width - self.itemSize.width) / 2
    self.sectionInset = UIEdgeInsets.init(top: 0, left: horizontalInset,
                                          bottom: 0, right: horizontalInset)
    
    let scaledItemOffset = (self.itemSize.width - self.itemSize.width * self.sideItemScale) / 2
    self.minimumLineSpacing = self.spacing - scaledItemOffset
  }
  
  // 매번 레이아웃을 업데이트 하도록 설정 (기본값은 false)
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  // 각 아이템의 레이아웃 속성
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return super.layoutAttributesForElements(in: rect)?.compactMap { self.transform($0) }
  }
  
  // 각 아이템의 레이아웃 속성 변환
  private func transform(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    guard let collectionView = self.collectionView else { return attributes }
    
    let contentOffsetX = collectionView.contentOffset.x
    let normalizedCenter = attributes.center.x - contentOffsetX
    
    let maxDistance = self.itemSize.width + self.minimumLineSpacing
    // 아이템의 중앙과 컬렉션 뷰의 중앙 사이의 거리를 계산
    let distance = min(abs(collectionView.center.x - normalizedCenter), maxDistance)
    let ratio = (maxDistance - distance) / maxDistance // 거리에 따른 scale 비율
    
    // 거리에 따라 아이템의 스케일(비율로) 계산
    let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
    attributes.alpha = 1
    // 아이템의 크기와 위치 변형
    attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    attributes.zIndex = Int(scale * 10)
    
    return attributes
  }
  
  // 스크롤이 끝나려는 시점에 호출, 스크롤이 멈출 위치를 제어
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                    withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView,
          collectionView.isPagingEnabled == false,
          let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds) else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    let midSide = collectionView.bounds.size.width / 2
    // 컬렉션뷰의 중앙지점에 제안된 오프셋의 중앙 지점을 더해 새로운 중앙 지점을 계산
    let proposedContentOffsetCenter = proposedContentOffset.x + midSide
    
    let closest = layoutAttributes.min {
      abs($0.center.x - proposedContentOffsetCenter) < abs($1.center.x - proposedContentOffsetCenter)
    } ?? UICollectionViewLayoutAttributes()

    let targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
    
    return targetContentOffset
  }
}
```       

</details>
                                                                      
### 2차 문제 상황
- 기존의 FlowLayout을 커스텀한 버전도 동작은 잘 되었지만, 중첩 컬렉션뷰의 특성 상 코드의 흐름이 알기 어려워지고 컬렉션뷰 -> 셀 -> 컬렉션뷰 -> 셀 의 형태였기 때문에 데이터의 흐름도 깊어지는 단점이 발생했음
- 이전에는 Compositional Layout 으로 구현하려다 실패한 Carousel 구현을 다시 한 번 시도 해 보기로 결정
  > 포기 지점: Compositional Layout 으로는 중첩 형태를 구현해서 contentOffset을 출력해도 x축의 좌표를 알아낼 수 없었음. 
- Compositional Layout은 비교적 최근에 공개된 API이기 때문에 Reference를 찾기 어려웠음.
- 그러다 `visibleItemsInvalidationHandler` 를 알게 되어서 다시 한 번 도전함
    > 공식문서: A closure called before each layout cycle to allow modification of the items in the section immediately before they’re displayed.
    > 항목이 표시되기 직전에 섹션의 항목을 수정할 수 있도록 각 레이아웃 주기 전에 호출되는 클로저입니다.
    > https://developer.apple.com/documentation/uikit/nscollectionlayoutsection/3199096-visibleitemsinvalidationhandler

## 최종 구현 - CompositionalLayout에 적용
- 아래와 같이 `visibleItemsInvalidationHandler` 에 적용함으로서 offset를 가져올 수 있었고, 
- 현재 표시되고 있는 visibleItems의 정보를 가져옴으로서 셀 아이템들의 중심부로부터의 거리를 계산 해 tranform을 적용할 수 있었음.
- 덕분에 중첩 컬렉션뷰를 사용하지 않을 수 있어 Carousel의 행에 해당했던 CarouselCell를 삭제할 수 있었고, 뷰간 데이터의 흐름이 명확해지는 장점이 발생.

![EasyCloset 관련 003](https://github.com/qwerty3345/ios-closet-app/assets/59835351/88ccc209-dacf-4b00-94d9-6ffcf3e38998)
    
```swift 
 /// Carousel 을 적용하기 위해 셀 아이템에 중심부 부터의 거리를 계산 해 transform 을 적용
private func setupCollectionViewCarousel(to section: NSCollectionLayoutSection) {
  section.visibleItemsInvalidationHandler = { visibleItems, offset, environment in
    
    // 헤더가 아닌 셀 아이템들
    let cellItems = visibleItems.filter {
      $0.representedElementKind != UICollectionView.elementKindSectionHeader
    }
    let containerWidth = environment.container.contentSize.width
    
    cellItems.forEach { item in
      let itemCenterRelativeToOffset = item.frame.midX - offset.x
      
      // 셀이 컬렉션 뷰의 중앙에서 얼마나 떨어져 있는지
      let distanceFromCenter = abs(itemCenterRelativeToOffset - containerWidth / 2.0)
      
      // 셀이 커지고 작아질 때의 최대 스케일, 최소 스케일
      let minScale: CGFloat = 0.7
      let maxScale: CGFloat = 1.0
      let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
      
      item.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
  }
}
```

</details>
    

## ⚪️ Cell에 shadow와 cornerRadius 같이 주기

<details>
<summary>masksToBound 관련 이슈 해결, POP 확장</summary>

### 배경

- `layer`의 masksToBound 를 true 로 줌으로서 바운드를 기준으로 잘라서 cornerRadius를 구현할 수 있었음.
- 근데, 그림자를 주려면 `layer` 바깥에 잘리지 않아야 하기에 masksToBound 를 false 로 줘야 하는 충돌이 일어나는 현상이 발생
    
### 해결
- `contentView` 를 활용하여 masksToBound를 따로 줌
    > 만약 셀이 아니라, contentView가 없다면 내부에 containerView를 만들어 처리할 수도 있음
1. 먼저 self에 addSubView로 추가했던 UI 컴포넌트 들을 contentView에 addSubview하는 것으로 수정
2. contentView에는 layer에 masksToBound = true 로 주고 cornerRadius를 설정하고
3. 그냥 cell의 layer에는 masksToBound = false 를 주며 그림자 관련 속성을 설정한다. 
    > 참고 한 아티클
    [Adding rounded corner and drop shadow to UICollectionViewCell](https://stackoverflow.com/questions/13505379/adding-rounded-corner-and-drop-shadow-to-uicollectionviewcell)

- 이에 이렇게 CollectionViewCell의 extension으로 그림자를 주는 메서드를 작성함
```swift
extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
```

### 추가 구현
    
- 하지만 위의 코드는 마음에 들지 않았다. TableView 에도 동일한 현상이 발생할 것 같은데, 그럼 따로 extension func을 처리해줘야 할 것 같았기에.
- 그래서 POP 로 구현해서 확장함!

```swift
protocol ShadowDecoratableCellType {
  var contentView: UIView { get }
  var layer: CALayer { get }
}
extension UICollectionViewCell: ShadowDecoratableCellType {}
extension UITableViewCell: ShadowDecoratableCellType {}
```

```swift
extension ShadowDecoratableCellType {
  func shadowDecorate() {
    let radius: CGFloat = 10
    contentView.layer.cornerRadius = radius
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.clear.cgColor
    contentView.layer.masksToBounds = true
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1.0)
    layer.shadowRadius = 10.0
    layer.shadowOpacity = 0.1
    layer.masksToBounds = false
    layer.cornerRadius = radius
  }
}
```

- 또한 여기서 확장성을 가져가서, UIView의 extension으로 그림자를 추가하는 extension 유틸을 구현하고, 해당 메서드를 사용하게 함

```swift
extension UIView {
  enum ShadowLocation {
    case top
    case bottom
    case left
    case right
  }
  
  func addShadow(to location: ShadowLocation, length: CGFloat = 5,
                 color: UIColor = .black, opacity: Float = 0.2,
                 radius: CGFloat = 5.0) {
    switch location {
    case .bottom:
      addShadow(offset: CGSize(width: 0, height: length), color: color, opacity: opacity, radius: radius)
    case .top:
      addShadow(offset: CGSize(width: 0, height: -length), color: color, opacity: opacity, radius: radius)
    case .left:
      addShadow(offset: CGSize(width: -length, height: 0), color: color, opacity: opacity, radius: radius)
    case .right:
      addShadow(offset: CGSize(width: length, height: 0), color: color, opacity: opacity, radius: radius)
    }
  }
  
  func addShadow(to locations: [ShadowLocation], length: CGFloat = 5,
                 color: UIColor = .black, opacity: Float = 0.2,
                 radius: CGFloat = 5.0) {
    Set(locations).forEach { location in
      addShadow(to: location, length: length, color: color, opacity: opacity, radius: radius)
    }
  }
  
  private func addShadow(offset: CGSize, color: UIColor,
                         opacity: Float, radius: CGFloat) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOffset = offset
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
  }
}
```

- 또한 ShadowableCellType에 UIView 로 제약을 주었기에, layer 에 기본적으로 접근해서 사용이 가능해짐!
```swift
protocol ShadowableCellType where Self: UIView {
  var contentView: UIView { get }
}

extension UICollectionViewCell: ShadowableCellType {}
extension UITableViewCell: ShadowableCellType {}

extension ShadowableCellType {
  func addShadowToCell(withCornerRadius radius: CGFloat = 10, to loation: ShadowLocation) {
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = radius
    
    layer.cornerRadius = radius
    addShadow(to: loation)
  }
}
```
</details>

## 💰 이미지 캐싱 구현

<details>
<summary>NSCache를 통한 메모리 캐시 구현 / 저장 갯수, 용량 제한</summary>

### 배경
- 이미지 로딩 프로세스는 아래와 같음
    1. id값을 바탕으로 메모리 Cahche 에서 이미지를 가져오려고 시도
        - 있으면 → return
    2. 없으면 FileManager 에서 download 하고 return
        - 동시에 메모리 Cache에 저장
- 초기에 아래 코드처럼 단순히 Image Caching 매니저를 구현하였으나, 문제점이 떠오름
- NSCache가 내부적으로 처리를 해주겠지만, 혹시나 캐싱으로 저장되는 이미지가 너무 크거나 저장되는 이미지의 갯수가 너무 많다면?
- NSCache가 알아서 삭제해주는 정책이 있다고는 하지만 메모리를 불필요하게 사용하는 상황이 발생하지 않을까?
- 아주 큰 용량의 이미지로 테스트 해본 결과, 앱이 허용하는 메모리 까지는 거의 끝없이 저장함.
    
```swift 
final class ImageCacheManager {
  
  // MARK: - Singleton
  static let shared = ImageCacheManager()
  
  private init() { }
  
  // MARK: - Properties
  
  private let cache = NSCache<NSString, UIImage>()
  
  // MARK: - Public Methods
  
  func get(for key: String) -> UIImage? {
    cache.object(forKey: key as NSString)
  }
  
  func store(_ value: UIImage, for key: String) {
    cache.setObject(value, forKey: key as NSString)
  }
  
}
```

> NSCache에 대해 좀 더 깊이 학습하며 리팩터링 하기로 결정함

### 문제 해결을 위한 NSCache에 대한 학습
1. Thread Safe 할까? 
- Thread Safe 하다!
> 출처: 공식문서
> You can add, remove, and query items in the cache from different threads without having to lock the cache yourself.

    
2. NSCache 의 내부는 어떻게 생겼을까?
- 공식 문서의 내용 만으로는 이해에 한계가 있어 Swift Foundation 의 NSCache 코드를 뜯어봄
> 출처: https://github.com/apple/swift-corelibs-foundation/blob/main/Sources/Foundation/NSCache.swift
> 
- 내부적으로 NSLock을 사용해서 lock, unlock 을 해주기 때문에 thread safe 했던 것
```swift
open class NSCache<KeyType : AnyObject, ObjectType : AnyObject> : NSObject {
    private var _entries = Dictionary<NSCacheKey, NSCacheEntry<KeyType, ObjectType>>()
    private let _lock = NSLock()
    private var _totalCost = 0
    private var _head: NSCacheEntry<KeyType, ObjectType>?
```
- 또한 딕셔너리를 사용하지만, 내부의 `_entries` 의 value 인 `NSCacheEntry` 를 살펴보면 prev, next 를 가지는 `linkedList` 형태로 이루어져 있음! 

```swift
private class NSCacheEntry<KeyType : AnyObject, ObjectType : AnyObject> {
    var key: KeyType
    var value: ObjectType
    var cost: Int
    var prevByCost: NSCacheEntry?
    var nextByCost: NSCacheEntry?
    init(key: KeyType, value: ObjectType, cost: Int) {
        self.key = key
        self.value = value
        self.cost = cost
    }
}
```

3. NSCache가 딕셔너리와 다르게 키 값을 복사하지 않는다는 말에 대해?
- 이 부분도 의문이 들었지만, 내부 코드를 뜯어보니 조금은 이해되었음.
- 복사하지 않고 참조한다 = 참조 타입만 사용할 수 있다 = AnyObject로 구현해야 한다
- 그래서 key로 struct 타입인 String, Int 등은 사용하지 못하기에 브릿징을 통해 NSString 등으로 키값을 지정해줘야 했던 것.

```swift
open class NSCache<KeyType : **AnyObject**, ObjectType : AnyObject> : NSObject {
```

```swift
open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {
    let g = max(g, 0) // costLimit을 지정하지 않으면 기본은 0임.
    let keyRef = NSCacheKey(key)
```

```swift
fileprivate class NSCacheKey: NSObject {
    var value: AnyObject
    init(_ value: AnyObject) {
        self.value = value
        super.init()
    }
```

- 참조 타입 키값을 wrapping 하는 방식으로 NSCacheKey 로 저장하는 것을 알 수 있었음.


4. 캐싱이 지워지는 것에 대한 체크
> 갯수 제한, 용량 제한을 구현한 `ImageCacheManager` 에 해당 방식으로 캐싱이 삭제되는 것을 확인할 수 있었음.

```swift
extension ImageCacheManager: NSCacheDelegate {
  func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
    print("\(obj as? UIImage) 정보가 캐시에서 지워진다.")
  }
}
```

### 결국 내린 결론,

갯수에 대한 제한은 줄 수 있음. 
또한, 저장되는 각 이미지에 용량에 따라 차등적인 CostLimit을 줌으로서 
각 데이터나 총 저장되는 용량에 대한 제한을 간접적으로 줄 수 있음. 

```swift
open var totalCostLimit: Int = 0 // limits are imprecise/not strict
```

주석에 달려있듯이 정확하진 않다고 하긴 하지만, 사용해볼 수 있을 것 같다!

### 최종 구현
- 최종 리팩터링한 ImageCacheManager
- countLimit, totalCostLimit를 통해 캐싱 갯수 제한과 저장 용량 제한을 주었음

```swift
final class ImageCacheManager {
  
  // MARK: - Constants
  
  private enum Constants {
    static let initialByteLimit = 200 * megaByteUnit // 초기 제약: 200메가바이트
    static let kiloByteUnit = 1024
    static let megaByteUnit = 1024 * 1024
  }
  
  // MARK: - Singleton
  
  static let shared = ImageCacheManager()
  
  private init() {
    cache.countLimit = countLimit
    cache.totalCostLimit = byteLimit
  }
  
  // MARK: - Properties
  
  private let cache = NSCache<NSString, UIImage>()
  
  // 총 100개 까지만 캐싱함
  var countLimit = 100 {
    didSet { cache.countLimit = countLimit }
  }
  // 메모리 캐싱 시의 용량 제약 (기본값: 200메가바이트)
  var byteLimit: Int = Constants.initialByteLimit {
    didSet { cache.totalCostLimit = byteLimit }
  }
  var megaByteLimit: Int {
    get { byteLimit / Constants.megaByteUnit }
    set { byteLimit = newValue * Constants.megaByteUnit }
  }
  var kiloByteLimit: Int {
    get { byteLimit / Constants.kiloByteUnit }
    set { byteLimit = newValue * Constants.kiloByteUnit }
  }
  
  // MARK: - Public Methods
  
  func get(for id: UUID) -> UIImage? {
    cache.object(forKey: id.uuidString as NSString)
  }
  
  func store(_ value: UIImage, for id: UUID) {
    let bytesOfImage = value.pngData()?.count ?? 0
    cache.setObject(value, forKey: id.uuidString as NSString, cost: bytesOfImage)
  }
  
  func removeAll() {
    cache.removeAllObjects()
  }
}
```

> 테스트 결과 아쉬운 점은, UIImage 의 실제 이미지 사이즈를 측정하는 것이 쉽지 않았음.
> 
- 처음엔`jpegData(compressionQuality: 1.0).count` 으로 측정 했는데, jpeg 으로 변환 한 후의 data 사이즈를 측정하는 것이기에 실제 데이터 자체의 용량과는 차이가 있었음.
- 콜라쥬 등을 처리하기 위해 배경 색상을 날려줘야 하기 때문에,
이미지 저장을 png 로 해야 해서 png 로 저장하고 png 로 이미지 데이터를 계산하니 어느 정도 일치 해서 구현을 끝냄

> 주의해야 할 점은, cost를 지정하지 않으면 기본 값은 0 이기 때문에 costLimist 을 걸어주더라도 저장할 때 setObject에서 cost 를 지정하지 않는다면 무한히 캐싱이 저장될 수 있다.
> 
- NSCache는 캐시 히트에 따른 처리까지는 제공하지 않지만, 애초에 디스크 캐싱이 아닌, 메모리 캐싱이기에 더 가벼운 관점으로 접근해도 별 문제 없다고 판단됐음
</details>
    
## 🗳️ File Manager의 파일 입출력 Combine 으로 비동기 처리

<details>
<summary>FileManager의 Combine을 통한 비동기 처리, </summary>

### 배경
- 사용자가 추가한 옷의 이미지를 로컬에 파일로 저장하기 위해 FileManager를 사용
- 아래와 같이 처음에 구현한 FileManger 코드에서는 이미지를 가져올 때 파일 입출력을 main Thread 에서 그냥 돌리고 있었음
- 이미지가 크거나, 여러 요청이 동시 다발적으로 들어오게 되면 경우에는 문제가 발생할 수 있을 것이라 판단

```swift!
func save(image: UIImage, id: UUID) throws {
  guard let data = image.pngData(),
        let filePath = filePath(of: id) else { return }
  try data.write(to: filePath)
}

func load(withID id: UUID) -> UIImage? {
  guard let filePath = filePath(of: id) else { return nil }
  do {
    let data = try Data(contentsOf: filePath)
    return UIImage(data: data)
  } catch {
    return nil
  }
}
...
```

### 1차 리팩터링 - Completion Handler 방식으로 변경

- DispatchQueue의 global() 큐를 통해 백그라운드 스레드에서 돌리고, 결과값을 completion Handler 에서 처리하게끔 변경함
- write 작업은 `qos: .utility` 로 지시하고, read 작업은 기본 qos로 지시함

```swift
func save(image: UIImage, id: UUID, completion: ((FileManagerError?) -> Void)? = nil) {
    guard let data = image.pngData(),
          let filePath = filePath(of: id) else { return }

    DispatchQueue.global(qos: .utility).async {
      do {
        try data.write(to: filePath)
        completion?(nil)
      } catch {
        completion?(.failToWrite(error: error))
      }
    }
  }

  func load(withID id: UUID, completion: @escaping (UIImage?) -> Void) {
    guard let filePath = filePath(of: id) else {
      completion(nil)
      return
    }

    DispatchQueue.global().async {
      do {
        let data = try Data(contentsOf: filePath)
        let image = UIImage(data: data)
        completion(image)
      } catch {
        completion(nil)
      }
    }
  }
...
```

### 2차 문제 발생
- 그러나 이렇게 활용한다면… 데이터 배열을 받아와서 각각의 데이터에 이미지를 매핑해주고, 여러 이미지의 로딩이 다 완료되었을 때의 시점에 대해 completion 처리를 하기 위해서 아래와 같이 복잡하게 로직을 작성해야 했음.
    > DispatchGroup을 이용해서, 모든 비동기 작업이 완료되었을 때 completion을 호출하도록 처리.
- 이렇게 했을 때는 기존의 ViewModel 에서 사용자 입력 이벤트에 대해 Combine으로 바인딩 한 부분과도 잘 맞지 않고, 코드가 직관적이지 않아지는 단점이 발생함.
    > Combine으로 리팩터링 해보기로 결정

```swift
// Repository 에서 Clothes 목록을 가져오는 메서드
func fetchClothesList(completion: @escaping (ClothesList?) -> Void) {
    guard let realm = realm else {
      completion(nil)
      return
    }
 
    // Realm 에서 먼저 데이터를 가져오고,
    let clothesEntities = realm.objects(ClothesEntity.self)
    var clothesList = ClothesList(clothesByCategory: [:])

    let dispatchGroup = DispatchGroup()
    let serialQueue = DispatchQueue(label: "serialQueue")

    clothesEntities.forEach { entity in
      var model = entity.toModelWithoutImage()

      dispatchGroup.enter()

      // 각각의 옷 모델에 image를 매핑해준다.
      ImageFileStorage.shared.load(withID: model.id) { image in
        if let image = image {
          model.image = image
        }
        // 딕셔너리에 동시 접근 때문에 발생하는 문제를 serialQueue로 방지
        serialQueue.async {
          clothesList.clothesByCategory[model.category, default: []].append(model)
        }
        dispatchGroup.leave()
      }
    }

    // 모든 이미지의 로딩이 완료된 시점을 dispatchGroup으로 notify 함.
    dispatchGroup.notify(queue: .main) {
      completion(clothesList)
    }
  }
```

### 2차 리팩터링 - Combine 으로 리팩터링

1. 이미지를 로컬 파일에서 가져오는 로직을 Combine으로 구현
> Future를 사용한 이유: 한 번 값을 내밷고 바로 종료되는 것이 적합한 동작이라 판단했기 때문에.
> 공식문서: `A publisher that eventually produces a single value and then finishes or fails.`

```swift 
// ImageFileManager 의 이미지를 로딩하는 부분을 Combine으로 리팩터링
func load(withID id: UUID) -> AnyPublisher<UIImage, FileManagerError> {
return Future { promise in
  guard let filePath = self.filePath(of: id) else {
    promise(.failure(.invalidFilePath))
    return
  }

  do {
    let data = try Data(contentsOf: filePath)
    guard let image = UIImage(data: data) else {
      promise(.failure(.invalidData))
      return
    }
    promise(.success(image))
  } catch {
    promise(.failure(.failToWrite(error: error)))
  }
}
.receive(on: DispatchQueue.global())
.eraseToAnyPublisher()
}
```

2. Storage에서 모델을 가져오고 이미지를 매핑하는 로직 Combine으로 리팩터링
- `realm` 에서 먼저 entity 를 로딩하여 model 로 매핑 한 후, 
    `ImageFileManager`에서 이미지를 로딩하여 넣어주고 반환하는 
    `ClothesStorage`의 로직을 Combine으로 리팩터링

```swift
// ClothesStorage에서 리스트를 받아오는 부분
func fetchClothesList() -> AnyPublisher<ClothesList, StorageError> {
  return Future { [weak self] promise in
    guard let self = self else { return }

    guard let realm = self.realm else {
      promise(.failure(.realmNotInitialized))
      return
    }

    // 반영한 모델들을 다 합한 결과를 future로 내뱉음.
    let clothesEntities = realm.objects(ClothesEntity.self)
    var clothesList = ClothesList(clothesByCategory: [:])
    let clothesModelsWithoutImage = clothesEntities.map { $0.toModelWithoutImage() }

    // ImageFileStorage를 호출해 이미지를 로딩해서 clothes에 넣는 것을 처리하는 Publisher들
    let clothesWithImagePublishers: [AnyPublisher<Clothes, Never>] = clothesModelsWithoutImage.map { model in
      ImageFileStorage.shared.load(withID: model.id)
        .replaceError(with: UIImage())
        .map { image in
          var clothes = model
          clothes.image = image
          return clothes
        }
        .eraseToAnyPublisher()
    }

    // 위에서 만든 단일의 Clothes를 방출하는 여러 Publisher들을 모아서 [Clothes] 를 방출하는 하나의 Publisher로 만듬
    Publishers.MergeMany(clothesWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
      .sink { clothesArray in
        // 이미지가 모두 반영 된 ClothesList
        let clothesList = clothesArray.toClothesList()
        promise(.success(clothesList))
      }
      .store(in: &cancellables)
  }
  .eraseToAnyPublisher()
}
```

3. 메서드 분리
> ClothesStorage 내부의 combine 결합 로직이 커져서 메서드로 분리함

```swift
func fetchClothesList() -> AnyPublisher<ClothesList, StorageError> {
  return Future { [weak self] promise in
    guard let self = self else { return }
    
    guard let realm = realm else {
      promise(.failure(.realmNotInitialized))
      return
    }
    
    // 반영한 모델들을 다 합한 결과를 future로 내뱉음.
    let clothesEntities = Array(realm.objects(ClothesEntity.self))
    let clothesModelsWithoutImage = clothesEntities.map { $0.toModelWithoutImage() }
    
    addingImagePublishers(to: clothesModelsWithoutImage)
      .sink { clothesModels in
        // 이미지가 모두 반영 된 ClothesList
        let clothesList = clothesModels.toClothesList()
        promise(.success(clothesList))
      }
      .store(in: &cancellables)
  }
  .eraseToAnyPublisher()
}

private func addingImagePublishers(to clothesModels: [Clothes]) -> AnyPublisher<[Clothes], Never> {
  // ImageFileStorage를 호출해 이미지를 로딩해서 clothes에 넣는 것을 처리하는 Publisher들
  let clothesWithImagePublishers: [AnyPublisher<Clothes, Never>] = clothesModels.map { model in
    ImageFileStorage.shared.load(withID: model.id)
      .replaceError(with: UIImage())
      .map { image in
        var clothes = model
        clothes.image = image
        return clothes
      }
      .eraseToAnyPublisher()
  }
  
  // 위에서 만든 단일의 Clothes를 방출하는 여러 Publisher들을 모아서 [Clothes] 를 방출하는 하나의 Publisher로 만듬
  return Publishers.MergeMany(clothesWithImagePublishers)
    .collect()
    .eraseToAnyPublisher()
}
```
</details>
    
## 🏞️ 이미지 관련 Repository Protoco분리, POP 구현

<details>
<summary>이미지를 가져와서 모델 객체에 매핑하는 역할을 POP로 구현</summary>

### 배경
- Repository는 Realm, FileManager의 각 Storage들을 갖고 데이터를 처리함 
    현재 프로젝트에는 `ClothesRepository`, `StyleRepository` 두 Repository가 존재.
- StyleRepository 를 구현하던 중, Style 들을 가져올 때 각 스타일 내부에 있는 Clothes 객체에 이미지를 로딩해서 매핑해줘야 하는 작업이 똑같이 필요했음
    > Q. ClothesRepository에서 가져오면 되는 것 아닌가?
        - A. 조금 비효율적인 면이 존재할 수 있지만, 사용되는 Scene이 전혀 다르기 때문에 각각의 Repository가 별개로 동작하는 것이 더 적절하겠다고 생각했기에 별도로 구현하였고 필연적으로 중복 코드가 발생함.
- 공통되는 부분: **“이미지를 가져와서 로딩하는 부분”**
    - `ImageCacheManager`, `ImageFileStorage` 프로퍼티와 이미지를 Clothes 객체에 매핑해주는 부분을 프로토콜로 추상화하여 POP로 구현하기로 결정

### ImageFetchable POP 구현

- 아래처럼 이미지를 매핑 해 주는 부분을 protocol extension 으로 구현함.
    - 하지만 이런 방식은 오직 Clothes 에만 이미지를 매핑할 수 있으므로, 이미지를 매핑 받을 수 있는 protocol 타입을 정의하여 제네릭으로 차후 다른 모델 객체들도 이미지를 매핑할 수 있게 만들어주고 싶었음
    - → 이미지를 불러올 때 필요한 정보는 id값과 image 프로퍼티 두 가지만 필요하기에 해당 부분을 protocol 로 분리하여 여러 모델타입에 이미지를 매핑할 수 있게 구현하기로 결정

```swift
protocol ImageFetchable {
  var imageCacheManager: ImageCacheManager { get }
  var imageFileStorage: ImageFileStorageProtocol { get }
  func addingImages(to clothesModels: [Clothes]) -> AnyPublisher<[Clothes], Never>
}

extension ImageFetchable {
  var imageCacheManager: ImageCacheManager { .shared }
  var imageFileStorage: ImageFileStorageProtocol { ImageFileStorage.shared }

  func addingImages(to clothesModels: [Clothes]) -> AnyPublisher<[Clothes], Never> {
    let clothesWithImagePublishers: [AnyPublisher<Clothes, Never>] = clothesModels.map { model in
      if let image = imageCacheManager.get(for: model.id) {
        var clothes = model
        clothes.image = image
        return Just(clothes).eraseToAnyPublisher()
      }

      return imageFileStorage.load(withID: model.id)
        .replaceError(with: UIImage())
        .map { image in
          var clothes = model
          clothes.image = image
          return clothes
        }
        .eraseToAnyPublisher()
    }

    return Publishers.MergeMany(clothesWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
  }
}
```

### 최종 구현 - 여러 타입에 이미지를 매핑할 수 있게 구현

- 이미지를 매핑하는데 필요한 프로퍼티인 id, image만 분리하여 ImagableModel 이라는 프로토콜로 추상화함

```swift
protocol ImagableModel {
  var id: UUID { get }
  // 이미지를 매핑할 때 저장할 수 있어야 하므로 get set 둘 다 제약을 줌
  var image: UIImage? { get set }
}

// 이미지를 매핑할 모델 객체에 ImagbleModel 채택
struct Clothes: ImagableModel {
  let id: UUID
  var image: UIImage?
	...
}
```

- 아래처럼 `addingImages` 메서드에 `ImagableModel`로 제네릭을 줌으로서, 이미지를 가질 수 있는 (ImagebleModel을 채택한) 어떤 타입의 모델에 대해서도 매핑이 가능하게 되었음.

```swift
protocol ImageFetchableRepository {
  var imageCacheManager: ImageCacheManager { get }
  var imageFileStorage: ImageFileStorageProtocol { get }
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], RepositoryError>
}

extension ImageFetchableRepository {
  var imageCacheManager: ImageCacheManager { .shared }
  
  // storage에 저장된 이미지가 아직 로딩되지 않은 모델들에 이미지를 추가해서 매핑해줌
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], RepositoryError> {
    // 모델이 비어있으면 fail 반환
    guard imagableModels.isEmpty == false else {
      return Fail(error: RepositoryError.invalidData)
        .eraseToAnyPublisher()
    }
    
    let modelsWithImagePublishers = imagableModels.map { imagableModel in
			// 캐시에서 먼저 가져오도록 시도
      if let image = imageCacheManager.get(for: imagableModel.id) {
        var model = imagableModel
        model.image = image
        return Just(model)
          .setFailureType(to: RepositoryError.self)
          .eraseToAnyPublisher()
      }

			// 저장된 파일 스토리지에서 가져옴
      return imageFileStorage.load(withID: imagableModel.id)
        .replaceError(with: UIImage())
        .map { image in
          var model = imagableModel
          imageCacheManager.store(image, for: model.id) // 메모리 캐시에 저장
          model.image = image
          return model
        }
        .setFailureType(to: RepositoryError.self)
        .eraseToAnyPublisher()
    }
    
    return Publishers.MergeMany(modelsWithImagePublishers)
      .collect()
      .eraseToAnyPublisher()
  }
}
```

- Repository에서는 해당 ImageFetchable을 채택하고, 데이터를 받아온 후 `addingImages`를 호출 해주면 됨

```swift
final class ClothesRepository: ClothesRepositoryProtocol, ImageFetchableRepository {
	func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError> {
	  let clothesEntities = realmStorage.load(entityType: ClothesEntity.self)
	  let clothesModelsWithoutImage = clothesEntities.map { $0.toModelWithoutImage() }
	  return addingImages(to: clothesModelsWithoutImage)
	    .map { $0.toClothesList() }
	    .eraseToAnyPublisher()
	}
```
</details>
    
## 🧑‍🔬 유닛 테스트
    
<details>
<summary>ViewModel 유닛 테스트, CacheManager 유닛 테스트</summary>
    
### 배경
- 사용자의 액션의 로직을 담고 있는 ViewModel 의 unit-test 를 구현하고자 했음

### 유닛테스트를 위한 Mock Repository 구현

- ViewModel은 Repository에 의존하고 있으므로, 실제 Repository가 아닌 가상의 시나리오로 동작하는 Mock Repository를 구현하여 ViewModel을 테스트
    - Repository가 의존하고 있는 Storage 를 Mock으로 구현하여 Repository를 테스트 할 수도 있겠지만, 시간상 관계로 당장 급한 ViewModel부터 구현하기로 결정
    > 드디어 protocol 추상화, 의존성 주입이 빛을 발할 때가 되었다..!😲🥂
- 기존에 만들어놓은 Mock 객체들을 return 해주도록 구현함
    > 일단은 Repository가 성공의 시나리오만 발생시키도록 구현
    실패 시나리오가 필요할 시, 각 응답을 property 로 만들어 테스트 직전 원하는 결과를 주입시켜줄 수 있을 것 같았음
    > 

```swift
@testable import EasyCloset
import Combine

final class MockClothesRepository: ClothesRepositoryProtocol {
  func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError> {
    return Just(ClothesList.mocks)
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func save(clothes: Clothes) -> AnyPublisher<Void, RepositoryError> {
    return Just(())
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
  
  func removeAll() {
    return
  }
}
```

### ClothesViewModel 테스트

- 이처럼 `ClothesRepositoryProtocol` 를 구현한 `MockRepository`를 ViewModel 에 주입해서 `sut`를 초기화

```swift
final class ClothesViewModelTests: XCTestCase {
	var sut: ClothesViewModel!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    let mockRepository = MockClothesRepository()
    sut = ClothesViewModel(repository: mockRepository)
    cancellables = []
  }
```

- clothes가 특정 카테고리의 clothes만 내보내는지 테스트
    > given, when, then 패턴을 사용

```swift
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
```

- 최신순 filter가 적용되는지 테스트

```swift
func test_최신순_filter가_적용되는지_테스트() {
  // given
  let categories = ClothesCategory.allCases
  sut.searchFilters.send([.sort(.new)])
  
  // 각각의 카테고리에 대한 expectation
  var expectations: [XCTestExpectation] = []
  
  categories.forEach { category in
    let expectation = XCTestExpectation(description: category.korean)
    expectations.append(expectation)
    
    // when
    sut.clothes(of: category)
      .sink { clothes in
        let sortedClothes = clothes.sorted(by: { $0.createdAt > $1.createdAt })
        
        // then
        XCTAssertEqual(clothes, sortedClothes)
        expectation.fulfill()
      }
      .store(in: &cancellables)
  }
}
```

- 계절 filter가 적용되는지 테스트

```swift
func test_계절_filter가_적용되는지_테스트() {
  // given
  let categories = ClothesCategory.allCases
  let weatherFilterType: WeatherType = .fall
  sut.searchFilters.send([.weather(weatherFilterType)])
  
  // 각각의 카테고리에 대한 expectation
  var expectations: [XCTestExpectation] = []
  
  categories.forEach { category in
    let expectation = XCTestExpectation(description: category.korean)
    expectations.append(expectation)
    
    // when
    sut.clothes(of: category)
      .sink { clothes in
        
        // then
        XCTAssertTrue(clothes.allSatisfy {
          $0.weatherType == weatherFilterType
        })
        expectation.fulfill()
      }
      .store(in: &cancellables)
  }
}
```

### 이미지 캐시매니저 유닛 테스트
- 메모리 캐시인 NSCache 를 활용한 `ImageCacheManager` 를 테스트
- 싱글턴 형태이긴 했지만, 메모리 캐시이기 때문에 각각의 케이스 후 removeAll 만 호출 해 주면 문제없이 테스트를 진행할 수 있을 것이라 판단
- 특히, 위에서 명시했던 갯수제한과 용량제한이 적절히 이뤄지는지를 테스트하고 싶었음
    > 다만, 해당 테스트가 반드시 성공하리라는 보장은 할 수 없었는데, 
    NSCache의 특성상 `countLimit`과 `totalCostLimit`이 제공하는 limit이 imprecise 하다고 명시되어 있었기 때문.
    다행히, 어느 정도까지는 예상한 대로 동작하는 것을 확인할 수 있었음
    > 
- 저장시 갯수제한이 적용되는지 확인
```swift 
func test_저장시_갯수제한이_적용되는지_확인() {
  // given
  let ids = (0...10).map { _ in UUID() }
  let countLimit = 3
  
  // when
  sut.countLimit = countLimit // 캐싱 저장 이미지 수를 3개로 제한
  ids.forEach { id in
    sut.store(UIImage(), for: id)
  }
  
  // then
  let storedImages = ids
    .compactMap { sut.get(for: $0) }

  // 갯수 제한을 준 갯수보다 같거나 적게 저장되었는지 확인
  XCTAssertGreaterThanOrEqual(countLimit, storedImages.count)
}
```

- 저장시 용량제한이 적용되는지 확인
    - SF Symbol의 기본 이미지 5장을 저장하려고 시도하며,
    - 5장의 이미지 중 가장 작은 용량 * 3 으로 제약을 줌

```swift 
func test_저장시_용량제한이_적용되는지_확인() {
  // given
  let images = [
    UIImage(systemName: "pencil")!,
    UIImage(systemName: "pencil.slash")!,
    UIImage(systemName: "pencil.circle")!,
    UIImage(systemName: "pencil.circle.fill")!,
    UIImage(systemName: "pencil.line")!
  ]
	// 가장 작은 이미지 용량
  let imageDataSize = images.compactMap { $0.pngData()?.count }.min() ?? 0
  let ids = (0..<5).map { _ in UUID() }
  
  // when
  sut.byteLimit = imageDataSize * 3 // 대략 이미지 3개 정도의 사이즈만큼 용량 제한을 줌
  zip(images, ids).forEach { image, id in
    sut.store(image, for: id)
  }
  
  // then
  let storedImages = ids
    .compactMap { sut.get(for: $0) }

  // 용량 제한을 준 3개로 주었기에, 그보다 같거나 적게 저장되었는지 확인
  XCTAssertGreaterThanOrEqual(3, storedImages.count)
}
```
</details>
    
## ✅ 차후 학습, 작업 계획
- [ ] Repository, Local Storage의 unit-test 구현
- [ ] 객체를 register, resolve할 수 있는 DI Container 구성
    - 현재는 팩토리 메서드 패턴 방식으로 단순히 뷰컨트롤러를 생성할 때 각각의 의존성을 주입해주는 방식으로 구현했는데, 다른 두 뷰컨트롤러가 동일한 뷰모델을 공유해야 하는 상황도 발생함.
    - Swinject 와 같은 라이브러리는 어떠한 방식으로 의존성 주입을 쉽게 하는지 분석, 학습 예정
- [ ] Firebase 서버 연결
    - 현재는 Local Storage 가 메인 저장소인데, Firebase 저장소에 백업을 하고 사용자 인증을 마치면 해당 내용을 다른 기기에서도 불러올 수 있게 구현 예정
