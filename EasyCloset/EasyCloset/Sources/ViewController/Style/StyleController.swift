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
  
  private lazy var dataSource: DataSource = makeDataSource()
  
  private let viewModel: StyleViewModel
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Initialization
  
  init(viewModel: StyleViewModel) {
    self.viewModel = viewModel
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  // MARK: - Private Methods
  
  private func bind() {
    viewModel.$styles
      .receive(on: DispatchQueue.main)
      .sink { [weak self] styles in
        self?.applySnapshot(with: styles)
      }
      .store(in: &cancellables)
  }
  
  private func applySnapshot(with styles: [Style]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Style>()
    snapshot.appendSections([.main])
    
    snapshot.appendItems(styles, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func tappedAddButton() {
    let detailController = DIContainer.shared.makeStyleDetailController(type: .add)
    detailController.delegate = self
    navigationController?.pushViewController(detailController, animated: true)
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
    setupAddButton()
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
  
  private func setupAddButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                        target: self,
                                                        action: #selector(tappedAddButton))
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
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    guard let style = dataSource.itemIdentifier(for: indexPath) else { return }
    let detailController = DIContainer.shared.makeStyleDetailController(type: .showDetail(style: style))
    detailController.delegate = self
    navigationController?.pushViewController(detailController, animated: true)
  }
}

// MARK: - StyleDetailControllerDelegate

extension StyleController: StyleDetailControllerDelegate {
  func styleDetailController(didUpdateOrSave viewController: StyleDetailController) {
    viewModel.stylesDidUpdate.send()
  }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct StyleControllerPreview: PreviewProvider {
  static var previews: some View {
    let vc = DIContainer.shared.makeStyleController()
    return UINavigationController(rootViewController: vc).toPreview()
  }
}
#endif
