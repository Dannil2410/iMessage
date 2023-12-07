//
//  SetupProfileViewController.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 28.11.2023.
//

import UIKit
import SnapKit

final class SetupProfileViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: UI
    
    private lazy var setupProfileLabel: UILabel = UILabel(text: "Set up Profile", font: .avenir26())
    private lazy var fullNameLabel: UILabel = UILabel(text: "Full name")
    private lazy var aboutMeLabel: UILabel = UILabel(text: "About Me")
    private lazy var sexLabel: UILabel = UILabel(text: "Sex")
    
    private lazy var fullNameTextField: UITextField = OneLineTextField()
    private lazy var aboutMeTextField: UITextField = OneLineTextField()
    
    private lazy var addPhotoView = AddPhotoView()
    
    private lazy var sexSegmentedControl: UISegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    private lazy var goToChatsButton: UIButton = UIButton(
        title: "Go to chats!",
        titleColor: .customColor.white,
        backgroundColor: .customColor.black,
        isShadow: false
    )
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    //MARK: Stored
    
    private let viewModel: SetupProfileViewModel

    //MARK: - Lifecircle
    
    init(viewModel: SetupProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureSubviews()
        configureTapGR()
        configureKeyboardInteraction()
        configureButtonsAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

//MARK: - configureSubviews

extension SetupProfileViewController {
    private func configureSubviews() {
        //scrollView
        scrollView.showsVerticalScrollIndicator = false
        let contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //topViews
        contentView.addSubview(setupProfileLabel)
        contentView.addSubview(addPhotoView)
        
        //contentViews
        let fullNameStackView = FormView(label: fullNameLabel, textField: fullNameTextField)
        let aboutMeStackView = FormView(label: aboutMeLabel, textField: aboutMeTextField)
        let sexStackView = FormView(label: sexLabel, segmentedControl: sexSegmentedControl)
        
        let mainStackView = UIStackView(
            arrangedSubviews: [fullNameStackView, aboutMeStackView, sexStackView, goToChatsButton],
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
        
        setupProfileLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        
        addPhotoView.snp.makeConstraints {
            $0.top.equalTo(setupProfileLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        goToChatsButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(addPhotoView.snp.bottom).offset(60)
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
        }
    }
}

//MARK: - configureTapGR

extension SetupProfileViewController {
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

extension SetupProfileViewController {
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

extension SetupProfileViewController {
    private func configureButtonsAction() {
        addPhotoView.addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addPhotoButtonTapped() {
        print(#function)
    }
    
    @objc
    private func goToChatsButtonTapped() {
        viewModel.delegate?.goToChatsButtonPressed()
    }
}
