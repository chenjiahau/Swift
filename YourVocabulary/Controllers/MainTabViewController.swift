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
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUser()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        let studyVC = StudyViewController()
        let studyNav = generateNavigationController(title: "Subject", image: UIImage(systemName: "calendar.circle"), viewController: studyVC)
        
        let settingVC = SettingViewController()
        let settingNav = generateNavigationController(title: "Setting", image: UIImage(systemName: "square.grid.3x3"), viewController: settingVC)
        
        viewControllers = [studyNav, settingNav]

        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = UIColor.appMainColor
        UITabBar.appearance().unselectedItemTintColor = .gray
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
            configureUI()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: MainTabViewController logUserOut error \(error.localizedDescription)")
        }
    }

}

