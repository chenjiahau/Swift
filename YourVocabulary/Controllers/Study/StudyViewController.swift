//
//  StudyViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/18.
//

import UIKit

class StudyViewController: UIViewController {
    
    // MARK: UI properties
    private let appIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constant.iconSize / 2
        imageView.layer.masksToBounds = true
        // imageView.layer.borderColor = UIColor.appSecondColor?.cgColor
        // imageView.layer.borderWidth = 2
        
        return imageView
    }()
    
    private let appTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .appMainColor
        
        return label
    }()
    
    private let addSubjectButton: UIButton = {
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
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appMainColor
        view.layer.opacity = 0.9
        
        return view
    }()
    
    private lazy var subjectView: SubjectViewController = {
        let view = SubjectViewController()
        
        return view
    }()
    
    
    // MARK: Data properties
    private var subjectList: [Subject] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        makeDummyData()
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
        
        view.addSubview(addSubjectButton)
        addSubjectButton.anchor(
            top: appIcon.firstBaselineAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
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
        
        view.addSubview(subjectView)
        subjectView.anchor(
            top: dividerView.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
    
    // MARK: Selectors
    @objc func addSubject(_ sender: UIButton) {
        print("addSubject")
    }
}


extension StudyViewController {
    // MARK: Dummy data
    func makeDummyData() {
        subjectList.append(Subject(Title: "Dummy Lession 01"))
        subjectList.append(Subject(Title: "Dummy Lession 02"))
        subjectList.append(Subject(Title: "Dummy Lession 03"))
        subjectList.append(Subject(Title: "Dummy Lession 04"))
        subjectList.append(Subject(Title: "Dummy Lession 05"))
        subjectList.append(Subject(Title: "Dummy Lession 06"))
        subjectList.append(Subject(Title: "Dummy Lession 07"))
        subjectList.append(Subject(Title: "Dummy Lession 08"))
        subjectList.append(Subject(Title: "Dummy Lession 09"))
        subjectList.append(Subject(Title: "Dummy Lession 10"))
    }
}
