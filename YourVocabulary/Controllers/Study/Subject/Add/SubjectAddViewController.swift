//
//  SubjectAddViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/22.
//

import UIKit

class SubjectAddViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.title = "Add a New Subject"
    }
    
    // MARK: Selector
    
}
