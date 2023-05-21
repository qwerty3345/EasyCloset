//
//  CarouselLayout.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

/// UPCarouselFlowLayout 을 보고 참고해서 만든 Carousel Layout
/// https://github.com/zepojo/UPCarouselFlowLayout 을 참고

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
