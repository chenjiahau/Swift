//
//  ViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/5/28.
//

import UIKit
import Firebase

class MainTabViewController: UITabBarController {
    // MARK: Properties
    private let loadingLabel: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "Loading",
            font: UIFont.systemFont(ofSize: 24),
            color: .white
        )
        
        label.textAlignment = .center
        return label
    }()
    
    private var user: User? {
        didSet {
            self.loadingLabel.isHidden = true
            self.configureUI()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appMainColor
        view.addSubview(loadingLabel)
        loadingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = UIColor.appMainColor
        UITabBar.appearance().unselectedItemTintColor = .gray
        
        checkUser()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        let studyVC = StudyViewController(user: user!)
        let studyNav = generateNavigationController(title: "Subject", image: UIImage(systemName: "calendar.circle"), viewController: studyVC)
        
        let settingVC = SettingViewController()
        let settingNav = generateNavigationController(title: "Setting", image: UIImage(systemName: "square.grid.3x3"), viewController: settingVC)
        
        viewControllers = [studyNav, settingNav]
    }
    
    func generateNavigationController(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    // MARK: API
    func checkUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: LoginViewController())
                
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
            }
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            UserService.getUser(withUid: uid) { snapshot in
                let value = snapshot?.value as? NSDictionary
                let email = value?["email"] as? String ?? ""
                let username = value?["username"] as? String ?? ""
                self.user = User(email: email, username: username)
            }
        }
    }
}

