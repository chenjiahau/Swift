//
//  SignupController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/19.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    // MARK: Properties
    private let appIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLoginIcon"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIGenerater.makeInputContainer(systemName: "envelope", textField: emailTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = UIGenerater.makeInputContainer(systemName: "person.fill", textField: usernameTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIGenerater.makeInputContainer(systemName: "shield.lefthalf.filled", textField: passwordTextField)
        return view
    }()
    
    private lazy var confirmPasswordContainerView: UIView = {
        let view = UIGenerater.makeInputContainer(systemName: "shield.lefthalf.filled", textField: confirmPasswordTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Email")
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Username")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Password", isSecureTextEntry: true)
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Confirm Password", isSecureTextEntry: true)
        return textField
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIGenerater.makeSubmitButton(title: "Sign Up")
        
        button.addTarget(
            self,
            action: #selector(clickSignupButton(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var gotoLoginButton: UIButton = {
        let button = UIGenerater.makeGotoButton(firstSentence: "Have account, ", secondSentence: "Log In")
        
        button.addTarget(
            self,
            action: #selector(clickGotoLoginButton(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(appIcon)
        appIcon.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        appIcon.setDimensions(width: 150, height : 150)
        
        let stackView = UIStackView(
            arrangedSubviews: [
                emailContainerView,
                usernameContainerView,
                passwordContainerView,
                confirmPasswordContainerView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        stackView.anchor(
            top: appIcon.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 32,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        view.addSubview(signupButton)
        signupButton.anchor(
            top: stackView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16,
            height: 44
        )
        
        view.addSubview(gotoLoginButton)
        gotoLoginButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 8,
            paddingRight: 16,
            height: 32
        )
    }
    
    // MARK: Selector
    @objc func clickSignupButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if password != confirmPassword {
            return
        }
        
        
    }
    
    @objc func clickGotoLoginButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
