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
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.tintColor = .appMainColor
        imageView.image = UIImage(systemName: "envelope")
        imageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 12,
            paddingLeft: 8,
            width: 24,
            height: 24
        )
        
        view.addSubview(emailTextField)
        emailTextField.anchor(
            top: view.topAnchor,
            left: imageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 14,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        let dividerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .appMainColor
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            return view
        }()
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.tintColor = .appMainColor
        imageView.image = UIImage(systemName: "person.fill")
        imageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 12,
            paddingLeft: 8,
            width: 24,
            height: 24
        )
        
        view.addSubview(usernameTextField)
        usernameTextField.anchor(
            top: view.topAnchor,
            left: imageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 14,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        let dividerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .appMainColor
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            return view
        }()
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.tintColor = .appMainColor
        imageView.image = UIImage(systemName: "shield.lefthalf.filled")
        imageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 12,
            paddingLeft: 8,
            width: 24,
            height: 24
        )
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(
            top: view.topAnchor,
            left: imageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 14,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        let dividerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .appMainColor
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            return view
        }()
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        return view
    }()
    
    private lazy var confirmPasswordContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.tintColor = .appMainColor
        imageView.image = UIImage(systemName: "shield.lefthalf.filled")
        imageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 12,
            paddingLeft: 8,
            width: 24,
            height: 24
        )
        
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.anchor(
            top: view.topAnchor,
            left: imageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 14,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        let dividerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .appMainColor
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            return view
        }()
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.textColor = .appMainColor
        textField.font = UIFont.systemFont(ofSize: 18)
        
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Username"
        textField.autocapitalizationType = .none
        textField.textColor = .appMainColor
        textField.font = UIFont.systemFont(ofSize: 18)
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textColor = .appMainColor
        textField.font = UIFont.systemFont(ofSize: 18)
        
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Confirm Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textColor = .appMainColor
        textField.font = UIFont.systemFont(ofSize: 18)
        
        return textField
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appMainColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(clickSignupButton(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var gotoLoginButton: UIButton = {
        let button = UIButton(type: .system )
        
        let attributedTitle = NSMutableAttributedString(
            string: "Have account, ",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        attributedTitle.append(
            NSMutableAttributedString(
                string: "Log In",
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            )
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
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
        view.backgroundColor = .appSecondColor
        
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
