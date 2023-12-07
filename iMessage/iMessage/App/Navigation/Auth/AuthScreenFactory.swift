//
//  AuthScreenFactory.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import UIKit

struct AuthScreenFactory {
    static func authViewController(delegate: AuthViewControllerDelegate?) -> UIViewController {
        let authViewModel = AuthViewModel(delegate: delegate)
        return AuthViewController(viewModel: authViewModel)
    }

    static func loginViewController(delegate: LoginViewControllerDelegate?) -> UIViewController {
        let loginViewModel = LoginViewModel(delegate: delegate)
        return LoginViewController(viewModel: loginViewModel)
    }
}
