//
//  SignUpViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 26.11.2023.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: UI
    
    private lazy var welcomeLabel: UILabel = UILabel(text: "Good to see you!", font: .avenir26())
    
    private lazy var emailLabel: UILabel = UILabel(text: "Email")
    private lazy var passwordLabel: UILabel = UILabel(text: "Password")
    private lazy var confirmPasswordLabel: UILabel = UILabel(text: "Confirm password")
    private lazy var alreadyOnboardLabel: UILabel = UILabel(text: "Already onboard?")
    
    private lazy var emailTextField: UITextField = OneLineTextField()
    private lazy var passwordTextField: UITextField = OneLineTextField(isSecureTextEntry: true)
    private lazy var confirmPasswordTextField: UITextField = OneLineTextField(isSecureTextEntry: true)
    
    private lazy var signUpButton: UIButton = UIButton(
        title: "Sign up",
        titleColor: .customColor.white,
        backgroundColor: .customColor.black,
        isShadow: false
    )
    private lazy var loginButton: UIButton = UIButton(title: "Login", titleColor: .customColor.red, backgroundColor: .clear, isShadow: false, cornerRadius: 0)
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    //MARK: Stored
    
    private let viewModel: SignUpViewModel
    
    //MARK: - Lifecircle
    
    init(viewModel: SignUpViewModel) {
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

extension SignUpViewController {
    private func configureSubviews() {
        //scrollView
        scrollView.showsVerticalScrollIndicator = false
        let contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //topView
        contentView.addSubview(welcomeLabel)
        
        //contentView
        let emailFormView = FormView(label: emailLabel, textField: emailTextField)
        let passwordFormView = FormView(label: passwordLabel, textField: passwordTextField)
        let confirmPasswordFormView = FormView(label: confirmPasswordLabel, textField: confirmPasswordTextField)
        
        let textFieldStackView = UIStackView(arrangedSubviews: [emailFormView, passwordFormView, confirmPasswordFormView, signUpButton], axis: .vertical, spacing: 40)
        
        contentView.addSubview(textFieldStackView)
        
        //bottomView
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 0)
        contentView.addSubview(bottomStackView)
        
        //Constraints
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.height)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(100)
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
            
        }
        
        bottomStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(60)
        }
    }
}

//MARK: - configureTapGR

extension SignUpViewController {
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

extension SignUpViewController {
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

extension SignUpViewController {
    private func configureButtonsAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func signUpButtonTapped() {
        viewModel.delegate?.signUpButtonTapped()
    }
    
    @objc
    private func loginButtonTapped() {
        dismiss(animated: true)
        viewModel.delegate?.signUpLoginButtonTapped()
    }
}
