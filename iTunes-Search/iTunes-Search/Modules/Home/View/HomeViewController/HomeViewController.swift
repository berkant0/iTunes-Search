//
//  HomeViewController.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    
}

final class HomeViewController: UIViewController {

    // MARK: Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MediaItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MediaItem>

    // MARK: Properties
    private var sections: [Section] = []
    private var snapshot = NSDiffableDataSourceSnapshot<Section, MediaItem>()
    private lazy var dataSource = generateDatasource()

    private enum Constant {
        static let sectionInset = 2.0
        static let half = 0.5
        static let full = 1.0
        static let headerHeight = 44.0
    }

    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionView()
        applySnapshot(animatingDifferences: false)
        setupSupplementryView()
    }
    
    func registerCollectionView() {
        let compositionalLayout = generateCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.identifier
        )
        collectionView.delegate = self
    }
}

// MARK: - Helpers
private extension HomeViewController {
    /// Applies new data to dataSource
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    /// Generates `UICollectionViewDiffableDataSource`
    func generateDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
                    return .init(frame: .zero)
                }

                return cell
            })

        return dataSource
    }
    /// Setups `Section`
    func setupSupplementryView() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as? SectionHeaderReusableView

            view?.titleLabel.text = section.title

            return view
        }
    }
    /// Generates `UICollectionViewCompositionalLayout` with given items, group, header and section
    func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = generateLayoutItems()

        // Group
        let groupDimension = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .fractionalHeight(Constant.half)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupDimension, subitems: [item])

        return .init(section: generateSection(for: group))
    }
    /// Generates `NSCollectionLayoutItem` with given dimensions
    func generateLayoutItems() -> NSCollectionLayoutItem {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.half),
            heightDimension: .fractionalHeight(Constant.full)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: Constant.sectionInset, leading: Constant.sectionInset, bottom: Constant.sectionInset, trailing: Constant.sectionInset)

        return item
    }
    /// Generates `NSCollectionLayoutBoundarySupplementaryItem` with given dimensions
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemDimension = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.headerHeight)
        )
        return .init(layoutSize: headerItemDimension, elementKind: UICollectionView.elementKindSectionHeader,  alignment: .top)
    }
    /// Generates `NSCollectionLayoutSection` with given group
    func generateSection(for group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constant.sectionInset,
            leading: Constant.sectionInset,
            bottom: Constant.sectionInset,
            trailing: Constant.sectionInset
        )

        section.boundarySupplementaryItems = [generateHeader()]

        return section
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

}
