//
//  LoginController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/19.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Properties
    private let appIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLoginIcon"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private var errorMessageView: UIView = {
        let view = UIGenerater.makeMessageView()
        return view
    }()
    
    private var errorMessageLabel: UILabel = {
        let label = UIGenerater.makeErrorMessagelabel()
        return label
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
        
        let stackView = UIStackView(arrangedSubviews: [errorMessageView, emailContainerView, passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        errorMessageView.addSubview(errorMessageLabel)
        errorMessageLabel.anchor(
            top: errorMessageView.topAnchor,
            left: errorMessageView.leftAnchor,
            bottom: errorMessageView.bottomAnchor,
            right: errorMessageView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8,
            paddingRight: 8
        )
        
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
                self.errorMessageView.isHidden = false
                self.errorMessageLabel.text = error.localizedDescription
                return
            }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            UserService.getUser(withUid: uid) { snapshot in
                let value = snapshot?.value as? NSDictionary
                let email = value?["email"] as? String ?? ""
                let username = value?["username"] as? String ?? ""
                let user = User(email: email, username: username)
                
                guard let mainTabViewController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? MainTabViewController else { return }
                mainTabViewController.configureUI(user)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func clickGotoSignupButton(_ sender: UIButton) {
        errorMessageView.isHidden = true
        let destinationController = SignupViewController()
        navigationController?.pushViewController(destinationController, animated: true)
    }
}
