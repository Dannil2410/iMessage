//
//  SetupProfileViewModel.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import Foundation

protocol SetupProfileViewControllerDelegate: AnyObject {
    func goToChatsButtonPressed()
}

final class SetupProfileViewModel {
    
    weak var delegate: SetupProfileViewControllerDelegate?
    
    init(delegate: SetupProfileViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}
