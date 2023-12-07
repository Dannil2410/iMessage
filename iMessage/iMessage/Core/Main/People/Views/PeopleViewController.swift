//
//  PeopleViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit
import SnapKit

final class PeopleViewController: UIViewController, PeopleBaseCoordinated {
    
    enum Section: Int {
        case users
        
        func description(usersCount: Int) -> String {
            switch self {
            case .users:
                return "\(usersCount) people nearby"
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var users: [MUser] = Bundle.main.decode([MUser].self, from: "users.json")
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, MUser>?
    
    var coordinator: PeopleBaseCoordinator?
    
    init(coordinator: PeopleBaseCoordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .customColor.background
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
        reloadData()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .customColor.background
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
    }

}

//MARK: - UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - DiffableDataSource

extension PeopleViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { 
            collectionView, indexPath, user in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            switch section {
            case .users:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
                    fatalError("Debug: Error by trying dequeue cell with identifier \(UserCell.identifier)")
                }
                
                cell.set(using: user)
                
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self,
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
                fatalError("Debug: Error by trying dequeue supplementaryView with identifier \(SectionHeaderView.identifier)")
            }
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            guard let items = self.dataSource?.snapshot().itemIdentifiers(inSection: .users) else {
                fatalError("DEBUG: Error by trying get current snapshot of section \(section.rawValue)")
            }
            
            sectionHeader.set(headerName: section.description(usersCount: items.count), font: .systemFont(ofSize: 36, weight: .light), textColor: .customColor.black)
            
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
        
        snapshot.appendSections([.users])
        snapshot.appendItems(users, toSection: .users)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Compositional layout

extension PeopleViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            switch section {
            case .users:
                return self.createUserCellLayout()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        return layout
    }
    
    private func createUserCellLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 16
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.6)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.boundarySupplementaryItems = [createSectionHeader()]

        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return sectionHeader
    }
}
