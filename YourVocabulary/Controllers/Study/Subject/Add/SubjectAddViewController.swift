//
//  SubjectAddViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/22.
//

import UIKit

class SubjectAddViewController: UIViewController {
    
    // MARK: Properties
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .appSecondColor
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 28 / 2
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.appSecondColor?.cgColor
        button.setTitle("Back", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(handleBack(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .appMainColor
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 28 / 2
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.appSecondColor?.cgColor
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(handleSave(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appMainColor
        view.layer.opacity = 0.9
        
        return view
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Add a New Subject"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        view.addSubview(dividerView)
        dividerView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0,
            height: 1
        )
    }
    
    
    // MARK: Selector
    
    @objc func handleBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func handleSave(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
