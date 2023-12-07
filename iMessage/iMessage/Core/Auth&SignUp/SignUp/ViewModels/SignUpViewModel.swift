//
//  SignUpViewModel.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import Foundation

protocol SignUpViewControllerDelegate: AnyObject {
    func signUpButtonTapped()
    func signUpLoginButtonTapped()
}

final class SignUpViewModel {
    
    weak var delegate: SignUpViewControllerDelegate?
    
    init(delegate: SignUpViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}
