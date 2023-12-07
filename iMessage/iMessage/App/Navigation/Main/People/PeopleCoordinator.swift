//
//  PeopleCoordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit

final class PeopleCoordinator: PeopleBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: PeopleViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        
    }

}
