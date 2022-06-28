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
    
    private var user: User? {
        didSet {
            self.configureUI(user!)
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appMainColor
        
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = UIColor.appMainColor
        UITabBar.appearance().unselectedItemTintColor = .gray
        
        checkUser()
    }
    
    // MARK: Helpers
    
    func configureUI(_ user: User) {
        let studyVC = StudyViewController(user: user)
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
            DispatchQueue.main.async {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                let navigation = UINavigationController(rootViewController: LoadingViewController())
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
                
                UserService.getUser(withUid: uid) { snapshot in
                    self.user = User.createUser(snapshot?.value as? NSDictionary)
                    navigation.dismiss(animated: true)
                }
            }
        }
    }
}

