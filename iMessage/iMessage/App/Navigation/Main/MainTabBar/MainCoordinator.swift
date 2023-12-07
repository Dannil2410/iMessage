//
//  MainCoordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit

enum AppFlow {
    case people
    case conversations
}

final class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var peopleCoordinator: PeopleBaseCoordinator = PeopleCoordinator()
    
    lazy var conversationsCoordinator: ConversationsBaseCoordinator = ConversationsCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        (rootViewController as? UITabBarController)?.tabBar.tintColor = .customColor.purple
        
        let peopleViewController = peopleCoordinator.start()
        peopleCoordinator.parentCoordinator = self
        peopleViewController.tabBarItem = UITabBarItem(
            title: "People",
            image: UIImage(systemName: "person.2", withConfiguration: boldConfig),
            tag: 0
        )
        
        let conversationsViewController = conversationsCoordinator.start()
        conversationsCoordinator.parentCoordinator = self
        conversationsViewController.tabBarItem = UITabBarItem(
            title: "Conversations",
            image: UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig),
            tag: 1
        )
        
        (rootViewController as? UITabBarController)?.viewControllers = [
            peopleViewController,
            conversationsViewController
        ]
        
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .people:
            goToPeopleFlow(flow)
        case .conversations:
            goToConversationsFlow(flow)
        }
    }
    
    private func goToPeopleFlow(_ flow: AppFlow) {
        peopleCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    
    private func goToConversationsFlow(_ flow: AppFlow) {
        conversationsCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
}
