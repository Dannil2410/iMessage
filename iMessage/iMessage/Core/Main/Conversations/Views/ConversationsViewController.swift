//
//  ConversationsViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit
import SnapKit

final class ConversationsViewController: UIViewController, ConversationsBaseCoordinated {
    
    enum Section: Int, CaseIterable, CustomStringConvertible {
        case waitingChats
        case activeChats
        
        var description: String {
            switch self {
            case .waitingChats:
                return "Waiting Chats"
            case .activeChats:
                return "Active Chats"
            }
        }
    }
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    
    private var activeChats: [MChat] = Bundle.main.decode([MChat].self, from: "activeChats.json")
    private var waitingChats: [MChat] = Bundle.main.decode([MChat].self, from: "waitingChats.json")
    
    var coordinator: ConversationsBaseCoordinator?
    
    init(coordinator: ConversationsBaseCoordinator? = nil) {
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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        tabBarController?.tabBar.backgroundColor = .white
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
        
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.identifier)
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.identifier)
    }
}

//MARK: - UISearchBarDelegate

extension ConversationsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - DiffableDataSource

extension ConversationsViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView) {
            [weak self] collectionView, indexPath, chat in
        
            guard let self = self,
                  let section = Section(rawValue: indexPath.section) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            switch section {
            case .waitingChats:
                return self.configureCell(WaitingChatCell.self, collectionView: collectionView, forValue: chat, forIndexPath: indexPath)
            case .activeChats:
                return self.configureCell(ActiveChatCell.self, collectionView: collectionView, forValue: chat, forIndexPath: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
                fatalError("Debug: Error by trying dequeue supplementaryView with identifier \(SectionHeaderView.identifier)")
            }
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            sectionHeader.set(headerName: section.description, font: .laoSangamMN20(), textColor: .customColor.secondaryText)
            
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MChat>()
        
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Compositional layout

extension ConversationsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("DEBUG: Unknowned section type!!!")
            }
            
            switch section {
            case .waitingChats:
                return self.createWaitingChatsSectionLayout()
            case .activeChats:
                return self.createActiveChatsSectionLayout()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    private func createWaitingChatsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(88),
            heightDimension: .absolute(88)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [createSectionHeader()]

        return section
    }
    
    private func createActiveChatsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(78)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        section.interGroupSpacing = 8
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
