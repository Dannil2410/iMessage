//
//  SignUpScreenFactory.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import UIKit

struct SignUpScreenFactory {
    static func signUpViewController(delegate: SignUpViewControllerDelegate?) -> UIViewController {
        let signUpViewModel = SignUpViewModel(delegate: delegate)
        return SignUpViewController(viewModel: signUpViewModel)
    }
    
    static func setupProfileViewController(delegate: SetupProfileViewControllerDelegate?) -> UIViewController {
        let setupViewModel = SetupProfileViewModel(delegate: delegate)
        return SetupProfileViewController(viewModel: setupViewModel)
    }
}
