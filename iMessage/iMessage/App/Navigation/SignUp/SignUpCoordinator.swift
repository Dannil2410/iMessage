//
//  SignUpCoordinator.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import UIKit

protocol SignUpCoordinatorDelegate: AnyObject {
    func signUpLoginButtonTapped()
    func presentMainScreen()
}

final class SignUpCoordinator {
    
    private var navVC: Routable?
    private weak var delegate: SignUpCoordinatorDelegate?
    
    init(delegate: SignUpCoordinatorDelegate?) {
        self.delegate = delegate
    }
    
    func presentSignUpViewController(using authNavVC: Routable?) {
        let signUpVC = SignUpScreenFactory.signUpViewController(delegate: self)
        let nav = UINavigationController(rootViewController: signUpVC)
        authNavVC?.presentViewController(nav, animated: true)
        navVC = nav
    }
}

//MARK: - SignUpViewControllerDelegate

extension SignUpCoordinator: SignUpViewControllerDelegate {
    func signUpButtonTapped() {
        let setupProfileVC = SignUpScreenFactory.setupProfileViewController(delegate: self)
        navVC?.showViewController(setupProfileVC, animated: true)
    }
    
    func signUpLoginButtonTapped() {
        delegate?.signUpLoginButtonTapped()
    }
}

//MARK: - SetupProfileViewControllerDelegate

extension SignUpCoordinator: SetupProfileViewControllerDelegate {
    func goToChatsButtonPressed() {
        delegate?.presentMainScreen()
        (navVC as? UINavigationController)?.modalPresentationStyle = .overFullScreen
//        navVC?.dismissViewController(animated: true)
        navVC?.presentViewController(MainCoordinator().start(), animated: true)
    }
}
