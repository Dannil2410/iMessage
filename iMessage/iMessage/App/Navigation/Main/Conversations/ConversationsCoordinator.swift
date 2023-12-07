//
//  ConversationsCoordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit

final class ConversationsCoordinator: ConversationsBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ConversationsViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        
    }
}
