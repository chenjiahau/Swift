//
//  LoginController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/19.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    private lazy var passwordContainerView: UIView = {
        let view = UIGenerater.makeInputContainer(systemName: "shield.lefthalf.filled", textField: passwordTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Email")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Password", isSecureTextEntry: true)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIGenerater.makeSubmitButton(title: "Log In")
        
        button.addTarget(
            self,
            action: #selector(clickLoginButton(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var gotoSignUpButton: UIButton = {
        let button = UIGenerater.makeGotoButton(firstSentence: "Don't have account, ", secondSentence: "Sign Up")
        
        button.addTarget(
            self,
            action: #selector(clickGotoSignupButton(_:)),
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
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
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
        
        view.addSubview(loginButton)
        loginButton.anchor(
            top: stackView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16,
            height: 44
        )
        
        view.addSubview(gotoSignUpButton)
        gotoSignUpButton.anchor(
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
    @objc func clickLoginButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthSerivce.logUserIn(withEmail: email, password: password) { (data, error) in
            if let error = error {
                print("DEBUG: AuthSerivce.logUserIn error is \(error.localizedDescription)")
            }
            
            guard let destinationController = UIApplication.shared.keyWindow?.rootViewController as? MainTabViewController else { return }
            destinationController.configureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func clickGotoSignupButton(_ sender: UIButton) {
        print(1)
        let destinationController = SignupViewController()
        navigationController?.pushViewController(destinationController, animated: true)
    }
}
