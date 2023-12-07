//
//  AuthViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 19.11.2023.
//

import UIKit
import SnapKit

final class AuthViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: UI
    
    private lazy var logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFit, renderingMode: .alwaysTemplate, .purple)
    
    private lazy var googleLabel = UILabel(text: "Get started with")
    private lazy var googleButton = UIButton(title: "Google", backgroundColor: .white)
    
    private lazy var emailLabel = UILabel(text: "Or sign up with")
    private lazy var emailButton = UIButton(
        title: "Email",
        titleColor: .customColor.white,
        backgroundColor: .customColor.black,
        isShadow: false
    )
    
    private lazy var loginLabel = UILabel(text: "Already onboard?")
    private lazy var loginButton = UIButton(
        title: "Login",
        titleColor: .customColor.red,
        backgroundColor: .customColor.white
    )
    
    //MARK: Stored
    
    private let viewModel: AuthViewModel
    
    //MARK: - Lifecircle
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customColor.white
        configureSubviews()
        buttonsTarget()
    }
}

//MARK: - configureSubviews

extension AuthViewController {
    private func configureSubviews() {
        //topView
        view.addSubview(logoImageView)
        
        //contentView
        googleButton.customizeGoogleButton()
        let googleButtonFormView = FormView(label: googleLabel, button: googleButton)
        let emailButtonFormView = FormView(label: emailLabel, button: emailButton)
        let loginButtonFormView = FormView(label: loginLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleButtonFormView, emailButtonFormView, loginButtonFormView], axis: .vertical)
        
        view.addSubview(stackView)
        
        //constraints
        logoImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView).offset(140)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}

//MARK: - buttonsTarget

extension AuthViewController {
    private func buttonsTarget() {
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func googleButtonTapped() {
        viewModel.delegate?.authGoogleButtonTapped()
    }
    
    @objc
    private func emailButtonTapped() {
        viewModel.delegate?.authEmailButtonTapped()
    }
    
    @objc
    private func loginButtonTapped() {
        viewModel.delegate?.authLoginButtonTapped()
    }
}
