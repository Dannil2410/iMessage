//
//  LoginViewModel.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func loginGoogleButtonPressed()
    func loginButtonPressed()
    func loginSignUpButtonPressed()
}

final class LoginViewModel {
    weak var delegate: LoginViewControllerDelegate?
    
    init(delegate: LoginViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}
