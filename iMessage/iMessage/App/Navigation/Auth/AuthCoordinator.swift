//
//  Coordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import UIKit

final class AuthCoordinator {
    private var signUpCoordinator: SignUpCoordinator?
    var navVC: Routable?
}

//MARK: - AuthViewControllerDelegate

extension AuthCoordinator: AuthViewControllerDelegate {
    func authGoogleButtonTapped() {
        print(#function)
    }
    
    func authEmailButtonTapped() {
        signUpCoordinator = SignUpCoordinator(delegate: self)
        signUpCoordinator?.presentSignUpViewController(using: navVC)
    }
    
    func authLoginButtonTapped() {
        let loginVC = AuthScreenFactory.loginViewController(delegate: self)
        navVC?.presentViewController(loginVC, animated: true)
    }
}

//MARK: - LoginViewControllerDelegate

extension AuthCoordinator: LoginViewControllerDelegate {
    func loginGoogleButtonPressed() {
        print(#function)
    }
    
    func loginButtonPressed() {
        presentMainScreen()
    }
    
    func loginSignUpButtonPressed() {
        navVC?.dismissViewController(animated: true)
        signUpCoordinator = SignUpCoordinator(delegate: self)
        signUpCoordinator?.presentSignUpViewController(using: navVC)
    }
}

//MARK: - SignUpCoordinatorDelegate

extension AuthCoordinator: SignUpCoordinatorDelegate {
    func signUpLoginButtonTapped() {
        let loginVC = AuthScreenFactory.loginViewController(delegate: self)
        navVC?.dismissViewController(animated: true)
        navVC?.presentViewController(loginVC, animated: true)
        signUpCoordinator = nil
    }
    
    func presentMainScreen() {
        navVC?.dismissViewController(animated: true)
        navVC?.fullScreenPresentViewController(MainCoordinator().start(), animated: true)
        signUpCoordinator = nil
    }
}
