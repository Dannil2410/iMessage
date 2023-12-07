//
//  AuthViewModel.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func authGoogleButtonTapped()
    func authEmailButtonTapped()
    func authLoginButtonTapped()
}

final class AuthViewModel {
    
    weak var delegate: AuthViewControllerDelegate?
    
    init(delegate: AuthViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}
