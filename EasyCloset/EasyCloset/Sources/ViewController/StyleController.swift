//
//  StyleController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/17.
//

import UIKit

import Combine

final class StyleController: UICollectionViewController {
  
  enum Section: CaseIterable {
    case main
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Style>
  
  // MARK: - Constants
  
  private enum Metric {
    static let cellPadding: CGFloat = 10
    static let horizontalInset: CGFloat = 20
    static let verticalInset: CGFloat = 24
    
    static let cellItemPadding: CGFloat = 8
  }
  
  // MARK: - Properties
  
  private let viewModel = StyleViewModel()
  
  private lazy var dataSource: DataSource = makeDataSource()
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI Components
  
  // MARK: - Initialization
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  // MARK: - Public Methods
  
  // MARK: - Private Methods
  
  private func bind() {
    viewModel.$styles
      .sink { [weak self] styles in
        guard let self = self else { return }
        self.applySnapshot(with: styles)
      }
      .store(in: &cancellables)
  }
  
  private func applySnapshot(with styles: [Style]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Style>()
    snapshot.appendSections([.main])
    
    snapshot.appendItems(styles, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - UI & Layout

extension StyleController {
  
  private func setup() {
    setUI()
    setupLayout()
    setupCollectionView()
  }
  
  private func setUI() {
    addLeftTitle(with: "MY STYLE")
  }
  
  private func setupLayout() {
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.minimumInteritemSpacing = Metric.cellItemPadding // 셀 사이의 간격
      flowLayout.minimumLineSpacing = 16 // 줄 사이의 간격
    }
  }
  
  private func setupCollectionView() {
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.registerCell(cellClass: StyleCell.self)
  }
  
  private func makeDataSource() -> DataSource {
    DataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(cellClass: StyleCell.self, for: indexPath)
      cell.configure(with: item)
      return cell
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StyleController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: Metric.verticalInset,
                        left: Metric.horizontalInset,
                        bottom: Metric.verticalInset,
                        right: Metric.horizontalInset)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthSize = (view.frame.width / 2) - Metric.horizontalInset - Metric.cellItemPadding
    let heightSize = view.frame.height * 0.3 - Metric.cellPadding
    return CGSize(width: widthSize, height: heightSize)
  }
}

// MARK: - UICollectionViewDelegate

extension StyleController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("\(indexPath) 셀 선택!")
  }
}
