//
//  LoginViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 27.11.2023.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: UI
    
    private lazy var welcomeBackLabel: UILabel = UILabel(text: "Welcome Back!", font: .avenir26())
    private lazy var loginWithLabel: UILabel = UILabel(text: "Login with")
    private lazy var orLabel: UILabel = UILabel(text: "or")
    private lazy var emailLabel: UILabel = UILabel(text: "Email")
    private lazy var passwordLabel: UILabel = UILabel(text: "Password")
    private lazy var needAccountLabel: UILabel = UILabel(text: "Need an account?")
    
    private lazy var emailTextField: UITextField = OneLineTextField()
    private lazy var passwordTextField: UITextField = OneLineTextField(isSecureTextEntry: true)
    
    private lazy var loginButton: UIButton = UIButton(
        title: "Login",
        titleColor: .customColor.white,
        backgroundColor: .customColor.black,
        isShadow: false
    )
    private lazy var googleButton: UIButton = UIButton(title: "Google", backgroundColor: .white)
    private lazy var signUpButton: UIButton = UIButton(title: "Sign up", titleColor: .customColor.red, backgroundColor: .clear, isShadow: false, cornerRadius: 0)
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    //MARK: Stored
    
    private let viewModel: LoginViewModel
    
    //MARK: - Lifecircle
    
    init(viewModel: LoginViewModel) {
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
        configureTapGR()
        configureKeyboardInteraction()
        configureButtonsAction()
    }
}

//MARK: - configureSubviews
extension LoginViewController {
    private func configureSubviews() {
        //scrollView
        scrollView.showsVerticalScrollIndicator = false
        let contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //topView
        contentView.addSubview(welcomeBackLabel)
        
        //contentView
        googleButton.customizeGoogleButton()
        let loginWithStackView = FormView(label: loginWithLabel, button: googleButton)
        let emailStackView = FormView(label: emailLabel, textField: emailTextField)
        let passwordStackView = FormView(label: passwordLabel, textField: passwordTextField)
        let bottomStackView = UIStackView(arrangedSubviews: [needAccountLabel, signUpButton], axis: .horizontal, spacing: 0)
        signUpButton.contentHorizontalAlignment = .leading
        
        let mainStackView = UIStackView(
            arrangedSubviews: [loginWithStackView, orLabel, emailStackView, passwordStackView, loginButton, bottomStackView],
            axis: .vertical,
            spacing: 40
        )
        
        contentView.addSubview(mainStackView)
        
        //constraints
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.height)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        welcomeBackLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.centerX.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(welcomeBackLabel.snp.bottom).offset(60)
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
        }
        
    }
}

//MARK: - configureTapGR

extension LoginViewController {
    private func configureTapGR() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGR)
    }
    
    @objc
    private func endEditing() {
        view.endEditing(true)
    }
}

//MARK: - configureKeyboardInteraction

extension LoginViewController {
    private func configureKeyboardInteraction() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return
        }

        let keyboardHeight = keyboardSize.cgRectValue.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
}

//MARK: - configureButtonsAction

extension LoginViewController {
    private func configureButtonsAction() {
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func googleButtonTapped() {
        viewModel.delegate?.loginGoogleButtonPressed()
    }
    
    @objc
    private func loginButtonTapped() {
        viewModel.delegate?.loginButtonPressed()
    }
    
    @objc
    private func signUpButtonTapped() {
        viewModel.delegate?.loginSignUpButtonPressed()
    }
}
