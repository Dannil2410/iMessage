//
//  MainBaseCoordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    var peopleCoordinator: PeopleBaseCoordinator { get }
    var conversationsCoordinator: ConversationsBaseCoordinator { get }
}

protocol PeopleBaseCoordinated {
    var coordinator: PeopleBaseCoordinator? { get }
}

protocol ConversationsBaseCoordinated {
    var coordinator: ConversationsBaseCoordinator? { get }
}
