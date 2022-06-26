//
//  StudyViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/18.
//

import UIKit
import Firebase

class StudyViewController: UIViewController {
    
    // MARK: UI properties
    private let user: User
    
    private let appIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constant.iconSize / 2
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let appTitle: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "",
            font: UIFont.systemFont(ofSize: 24),
            color: UIColor.appMainColor!
        )
        
        label.layer.opacity = 0.5
        return label
    }()
    
    private lazy var addSubjectButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .white
        button.backgroundColor = .appSecondColor
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 30 / 2
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.appSecondColor?.cgColor
        button.layer.borderWidth = 10
        button.addTarget(
            self,
            action: #selector(addSubject(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Hi! \(self.user.username)"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .appSecondColor
        
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .white
        button.backgroundColor = .appMainColor
        button.setImage(UIImage(systemName: "arrowshape.zigzag.forward.fill"), for: .normal)
        button.layer.cornerRadius = 30 / 2
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.appMainColor?.cgColor
        button.layer.borderWidth = 2
        button.addTarget(
            self,
            action: #selector(logUserOut(_:)),
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
    
    private lazy var subjectView: SubjectListViewController = {
        let view = SubjectListViewController()
        
        return view
    }()
    
    
    // MARK: Data properties
    private var subjectList: [Subject] = []
    
    // MARK: Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(appIcon)
        appIcon.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 0,
            paddingLeft: 8,
            width: 48,
            height: 48
        )
        
        view.addSubview(appTitle)
        appTitle.text = "\(Constant.appTitle)(\(subjectList.count))"
        appTitle.anchor(
            top: appIcon.firstBaselineAnchor,
            left: appIcon.rightAnchor,
            paddingTop: 10,
            paddingLeft: 12
        )
        
        view.addSubview(logoutButton)
        logoutButton.anchor(
            top: appIcon.firstBaselineAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingRight: 10,
            width: 30,
            height: 30
        )
        
        view.addSubview(addSubjectButton)
        addSubjectButton.anchor(
            top: appIcon.firstBaselineAnchor,
            right: logoutButton.leftAnchor,
            paddingTop: 10,
            paddingRight: 10,
            width: 30,
            height: 30
        )
        
        view.addSubview(dividerView)
        dividerView.anchor(
            top: appIcon.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 4,
            paddingLeft: 0,
            paddingRight: 0,
            height: 2
        )
        
        view.addSubview(greetingLabel)
        greetingLabel.anchor(
            top: dividerView.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        view.addSubview(subjectView)
        subjectView.anchor(
            top: greetingLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 12,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
    
    // MARK: Selectors
    
    @objc func logUserOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: LoginViewController())
                
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
            }
        } catch {
            print("DEBUG: StudyViewController logUserOut error \(error.localizedDescription)")
        }
    }
    
    @objc func addSubject(_ sender: UIButton) {
        let navigation = UINavigationController(rootViewController: SubjectAddViewController(user: user))
        
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true)
    }
}
