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

// 유닛 테스트
├── ClothesViewModelTests.swift
├── Data
│   ├── MockClothesRepository.swift
│   └── MockStyleRepository.swift
└── ImageCacheManagerTests.swift
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
	
![image](https://github.com/qwerty3345/ios-closet-app/assets/59835351/4c468ca4-a24c-4a5c-b6d9-8444dabf5f90)

- 초기엔 컬렉션뷰의 컴포지셔널 레이아웃으로 구성하려고 시도
- orthogonal 방식으로 툭툭 다음으로 넘어가게 구현하는 것은 쉬웠지만, 사용자의 스크롤에 따라 사이즈를 자연스럽게 키우고 줄이는 형태의 구현에서 막힘.
- CompositionalLayout에서 세로 스크롤 내부에 중첩 형태로 가로 스크롤을 구현 할 경우, contentOffset 을 출력하면 x좌표의 변경은 출력되지 않았음.
	> (각 섹션이 가로 스크롤을 하는 것이지, 전체 컬렉션뷰의 스크롤뷰가 가로 스크롤을 하는 것이 아니기 때문)

### 1차 구현 - FlowLayout 커스텀
- [UPCarouselFlowLayout](https://github.com/zepojo/UPCarouselFlowLayout) 라이브러리를 참고해, 뜯어보면서 필요한 부분만 뽑아서 따로 FlowLayout을 상속한 Custom Class 구현
- 각 상의/하의/…의 카테고리를 컬렉션뷰의 셀로 구성하고 해당 셀 내부에 가로로 스크롤 하는 Carousel 레이아웃의 컬렉션뷰가 들어가 있는 중첩 컬렉션뷰의 형태로 구현
![EasyCloset 관련 001](https://github.com/qwerty3345/ios-closet-app/assets/59835351/3f650c9a-3218-4388-981d-9ee426fcaaec)

<details>
<summary>구현한 CaroselFlowLayout 코드</summary>
    
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

### 1차 구현 방식의 문제점	
- 중첩 컬렉션뷰의 특성 상 "컬렉션뷰 -> 셀 -> 컬렉션뷰 -> 셀" 의 형태였기 때문에 코드의 흐름, 데이터의 흐름이 알기 어려워지는 현사 발생
- 셀이 재사용되기 때문에 발생되는 자잘한 이슈도 겪음

### 최종 구현 - CompositionalLayout에 적용
- 그러더 중, Compositional Layout의 공식 문서에서 `visibleItemsInvalidationHandler` 를 발견함.
- 해당 섹션의 scroll Offset를 가져올 수 있었고, 화면에 표시되고 있는 visibleItems의 정보를 가져와서 중심부로부터의 거리를 계산 해 tranform해줄 수 있었음
- 이렇게 단일 컬렉션뷰로 구성할 수 있었고 코드의 흐름과 데이터의 흐름이 훨씬 직관적이어짐
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

## 💰 이미지 캐싱 구현

<details>
<summary>NSCache를 통한 메모리 캐시 구현 / 저장 갯수, 용량 제한</summary>

### 배경
- 이미지 로딩 프로세스
<img width="783" alt="image" src="https://github.com/qwerty3345/ios-closet-app/assets/59835351/699bd82a-1b55-4ec4-8edb-c2132cdbe5da">
	
- 처음엔 단순히 NSCache에 저장만 하는 것으로 구현하였으나 문제점이 떠오름.
- NSCache가 내부적으로 처리를 해준다고는 하지만, 혹시나 캐싱으로 저장되는 이미지가 너무 크거나 저장되는 이미지의 갯수가 너무 많다면,
  앱이 구동되는 런타임에 메모리를 불필요하게 많이 사용하는 상황이 발생하지 않을까? 라는 생각이 떠오름
- 아주 큰 용량의 이미지로 테스트 해본 결과, 앱이 허용하는 메모리 까지는 거의 끝없이 저장하느 것을 확인할 수 있었음

> 초기 구현 _ 단순히 NSCache에 저장
```swift 
final class ImageCacheManager {
  static let shared = ImageCacheManager()  
	
  private let cache = NSCache<NSString, UIImage>()
	
  func get(for key: String) -> UIImage? {
    cache.object(forKey: key as NSString)
  }
  
  func store(_ value: UIImage, for key: String) {
    cache.setObject(value, forKey: key as NSString)
  }
```

> NSCache에 대해 좀 더 깊이 학습하며 리팩터링 하기로 결정함

### NSCache에 대한 학습
1. Thread Safe한 이유는?
- 내부적으로 `NSLock`을 사용하여 lock, unlock을 하기 때문에 thread safe 했던 것
```swift 
open class NSCache<KeyType : AnyObject, ObjectType : AnyObject> : NSObject {
    private let _lock = NSLock()
    ...
```

2. 내부 구조는 Dictionary + Linked List 구조임
- 캐싱이라는 작업 특성상 데이터를 추가, 삭제하는 작업이 빈번하게 발생하기 때문에 데이터를 밀고 당기기 쉽게 하기 위해 링크드리스트를 활용해서 해당 작업을 빠르게 처리하는 것이 아닐까.라고 생각
- 또한, 만약 링크드 리스트 구조만 사용한다면 탐색에 O(n)이 발생되기에 동시에 딕셔너리 구조를 사용함으로써 key값으로 데이터를 접근할 때 O(1)으로 빠르게 탐색하게 하는 것이라고 생각

```swift
open class NSCache<KeyType : AnyObject, ObjectType : AnyObject> : NSObject {
    private var _entries = Dictionary<NSCacheKey, NSCacheEntry<KeyType, ObjectType>>()
...
private class NSCacheEntry<KeyType : AnyObject, ObjectType : AnyObject> {
    var key: KeyType
    var value: ObjectType
    var cost: Int
    var prevByCost: NSCacheEntry?
    var nextByCost: NSCacheEntry?
...
```

3. 딕셔너리와 다르게 키 값을 복사하지 않는다?
- 복사하지 않고 참조한다 = 참조 타입만 사용할 수 있다 = AnyObject로 구현해야 한다.
- 그래서 key로 struct 타입인 String, Int 등은 사용하지 못하기에 브릿징을 통해 NSString 등으로 키값을 지정해줘야 했던 것.
- 또하 내부 entry Dictionary의 Key를 Wrapping하는 NSCacheKey라는 클래스가 존재함


```swift
open class NSCache<KeyType : AnyObject, ObjectType : AnyObject> : NSObject {
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

4. 캐싱이 삭제되는 것에 대한 체크
- NSCacheDelegate 의 willEvictObject를 구현함으로서 캐시 데이터가 삭제되는 것을 확인할 수 있음

```swift 
extension ImageCacheManager: NSCacheDelegate {
  func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
    print("\(obj as? UIImage) 정보가 캐시에서 지워진다.")
  }
}
```
	
5. countLimit, totalCostLimit
- countLimit으로 저장 갯수의 제한을 줄 수 있고,totalCostLimit으로 저장의 비용의 가중치를 부여해 특정 비용만큼 저장될 수 있게 할 수 있음.
- 주의해야 할 점은, 해당 수치들로 줄 수 있는 제약은 imprecise/not strict 정확하지 않을 수 있다라고 명시되어 있고,
- 또한 저장 시 cost를 지정 해 주지 않으면 totalCostLimit를 지정했더라도 기본 cost는 0이기 때문에 적용되지 않는 문제가 있을 수 있음.

```swift 
open class NSCache<KeyType : AnyObject, ObjectType : AnyObject> : NSObject {
  private var _totalCost = 0
  open var totalCostLimit: Int = 0 // limits are imprecise/not strict
  open var countLimit: Int = 0 // limits are imprecise/not strict

  open func setObject(_ obj: ObjectType, forKey key: KeyType) {
    setObject(obj, forKey: key, cost: 0)
  }
  
  open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {
    let g = max(g, 0)
...
```

### 최종 구현
- countLimit 캐싱 갯수 제한을 주었음
- totalCostLimit를 지정하고, 저장 시 각 이미지의 바이트 용량에 따라 차등적인 CostLimit을 줌으로서, 용량 제한을 간접적으로 줄 수 있음.

```swift
final class ImageCacheManager {
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
  
  func get(for id: UUID) -> UIImage? {
    cache.object(forKey: id.uuidString as NSString)
  }
  
  func store(_ value: UIImage, for id: UUID) {
    let bytesOfImage = value.pngData()?.count ?? 0
    cache.setObject(value, forKey: id.uuidString as NSString, cost: bytesOfImage)
  }
...
```
</details>
    
## 🗳️ File Manager의 파일 입출력 Combine 으로 비동기 처리

<details>
<summary>FileManager의 Combine을 통한 비동기 처리, </summary>

### 배경
- 사용자가 추가한 옷의 이미지를 로컬에 파일로 저장하기 위해 FileManager를 사용
- 아래와 같이 처음에 구현한 FileManger 코드에서는 이미지를 가져올 때 파일 입출력을 main Thread 에서 그냥 돌리고 있었음
- 이미지가 크거나, 여러 요청이 동시 다발적으로 들어오게 되면 경우에는 문제가 발생할 수 있을 것이라 판단
<img width="1002" alt="image" src="https://github.com/qwerty3345/ios-closet-app/assets/59835351/56e1b373-d794-456b-ade9-7fd825944b9d">

```swift 
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
  }
...
```

### 1차 리팩터링 - DispatchQueue + Completion Handler

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
- storage의 데이터인 entity 배열을 받아와서 각각의 entity에 이미지를 매핑해주고, DispatchGroup을 이용해서, 여러 이미지의 로딩이 다 완료되었을 때 completion을 호출하도록 처리
- 하지만 이렇게 구현 했을 때는 기존에 ViewModel 의 input, output에 대해 Combine으로 바인딩 한 부분과도 잘 맞지 않고, 코드가 직관적이지 않아지는 단점이 발생
- 이에 Combine으로 리팩터링하기로 결정
	
> Repository 에서 Clothes 목록을 가져오는 메서드 (파일매니저 메서드를 호출)

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

### 2차 리팩터링 - Combine

1. 이미지를 로컬 파일에서 가져오는 로직을 Combine으로 구현
- Future만 구현하고 `subscribe(on:)`을 해줬을 떄는 백그라운드 스레드로 변경되지 않았음 -> Future의 특성 때문
- Future는 생성되는 "즉시" 실행되기 때문에 stream을 바꾸기 전에 이미 호출한 스레드로 실행이 되는 형태
- 반면 Deferred 는 구독이 시작하는 순간에 클로저를 호출하기 때문에 Future를 Deferred로 감싸줌으로서, 호출을 지연할 수 있게 되어 stream을 백그라운드 스레드로 변경할 수 있게 됨
> 참고: https://stackoverflow.com/questions/62264708/execute-combine-future-in-background-thread-is-not-working

```swift 
// ImageFileManager 의 이미지를 로딩하는 부분을 Combine으로 리팩터링
func load(withID id: UUID) -> AnyPublisher<UIImage, FileManagerError> {
    return Deferred { // Deferred를 사용함으로서 Future가 즉시 바로 실행되지 않게 함
      Future { promise in
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
    }
    .subscribe(on: DispatchQueue.global()) // 백그라운드 스레드로로 upstream을 변경
    .eraseToAnyPublisher()
  }
```

2. 모델을 가져오고 이미지를 매핑하는 로직을 Combine으로 구현
- `realm` 에서 먼저 entity 를 로딩하여 model 로 매핑 한 후, `ImageFileManager`에서 이미지를 로딩하여 넣어주고 반환하는 
   `ClothesStorage`의 로직을 Combine으로 리팩터링 (아직 Repository 객체 분리 전이라 Storage끼리 서로 참조하고 있는 형태)

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
	
<img width="1192" alt="image" src="https://github.com/qwerty3345/ios-closet-app/assets/59835351/bc78fb7e-b152-4b88-aa57-abe76341aab6">

	
- StyleRepository 를 구현하던 중, Style 들을 가져올 때 각 스타일 내부에 있는 Clothes 객체에 "이미지를 가져와서 매핑"하는 작업이 똑같이 필요했음
    > Q. StyleRepository가 ClothesRepository에서 데이터르 가져오면 되는 것 아닌가?
        - A. 조금 비효율적인 면이 존재할 수 있지만, 사용되는 Scene이 전혀 다르기 때문에 각각의 Repository가 별개로 동작하는 것이 더 적절하겠다고 생각했기에 별도로 구현함. (ex. Clothes을 확인하지 않고, Style화면만 볼 수도 있기에...)
- 이미지를 매핑하는 로직을 프로토콜로 추상화하여 POP로 구현하기로 결정

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

- 이미지를 매핑하는데 필요한 프로퍼티인 id, image만 분리하여 ImagableModel 이라는 프로토콜로 추상화

```swift
protocol ImagableModel {
  var id: UUID { get }
  // 이미지를 매핑할 때 저장할 수 있어야 하므로 get set 둘 다 요구사항을 줌
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
	> 그 외 다른 부분의 구현 로직은 동일

```swift
protocol ImageFetchableRepository {
  func addingImages<T: ImagableModel>(to imagableModels: [T]) -> AnyPublisher<[T], RepositoryError>
...
```

- Repository에서는 해당 ImageFetchable을 채택하고, 데이터를 받아온 후 `addingImages`를 호출만 하면 되는 간단한 방식이 됨

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
	
<img width="1175" alt="image" src="https://github.com/qwerty3345/ios-closet-app/assets/59835351/52e06de9-6f13-4d4b-83ae-10b0a2b01cf9">

- ViewModel은 Repository에 의존하고 있으므로, 실제 Repository가 아닌 가상의 시나리오로 동작하는 Mock Repository를 구현하여 ViewModel을 테스트
    > 드디어 protocol 추상화, 의존성 주입이 빛을 발할 때가 되었다..!😲🥂
- 기존에 만들어놓은 Mock 객체들을 return 해주도록 구현함
    > 일단은 Repository가 성공의 시나리오만 발생시키도록 구현. 실패 시나리오가 필요할 시, 각 응답을 property 로 만들어 테스트 직전 원하는 결과를 주입시켜줄 수 있을 것 같았음
    > 

```swift
final class MockClothesRepository: ClothesRepositoryProtocol {
  func fetchClothesList() -> AnyPublisher<ClothesList, RepositoryError> {
    return Just(ClothesList.mocks)
      .setFailureType(to: RepositoryError.self)
      .eraseToAnyPublisher()
  }
...
```

### ClothesViewModel 테스트

- 이처럼 `ClothesRepositoryProtocol` 를 구현한 `MockRepository`를 ViewModel 에 주입해서 `sut`를 초기화

```swift
var sut: ClothesViewModel!

override func setUpWithError() throws {
  let mockRepository = MockClothesRepository()
  sut = ClothesViewModel(repository: mockRepository)
...
```

### 계절 filter가 적용되는지 테스트
- 사용자가 필터 검색을 입력한 시나리오인 filter르 걸었을 때,
- 기대하는 출력값이 나오는지 테스트

```swift
func test_계절_filter가_적용되는지_테스트() {
  // given
  let categories = ClothesCategory.allCases
  let weatherFilterType: WeatherType = .fall
  sut.searchFilters.send([.weather(weatherFilterType)]) // 계절 filter 검색
  
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
	 // 모든 결과값이 해당 filter와 동일한지 체크
          $0.weatherType == weatherFilterType
        })
        expectation.fulfill()
      }
      .store(in: &cancellables)
...
```

### 이미지 캐시매니저 유닛 테스트
- 메모리 캐시인 NSCache 를 활용한 `ImageCacheManager` 를 테스트
- 싱글턴 형태이긴 했지만, 메모리 캐시이기 때문에 각각의 케이스 후 removeAll 만 호출 해 주면 문제없이 테스트를 진행할 수 있을 것이라 판단
- 특히, 구현했던 갯수제한과 용량제한이 적절히 이뤄지는지를 테스트하고 싶었음
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
```
</details>
    
## ✅ 차후 학습, 작업 계획
- [ ] Repository, Local Storage의 unit-test 구현
- [ ] 객체를 register, resolve할 수 있는 DI Container 구성
    - 현재는 팩토리 메서드 패턴 방식으로 단순히 뷰컨트롤러를 생성할 때 각각의 의존성을 주입해주는 방식으로 구현했는데, 다른 두 뷰컨트롤러가 동일한 뷰모델을 공유해야 하는 상황도 발생함.
    - Swinject 와 같은 라이브러리는 어떠한 방식으로 의존성 주입을 쉽게 하는지 분석, 학습 예정
- [ ] Firebase 서버 연결
    - 현재는 Local Storage 가 메인 저장소인데, Firebase 저장소에 백업을 하고 사용자 인증을 마치면 해당 내용을 다른 기기에서도 불러올 수 있게 구현 예정
