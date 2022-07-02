//
//  SubjectAddViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/22.
//

import UIKit

class SubjectAddViewController: UIViewController {
    
    // MARK: Data Properties
    private let user: UserModel
    
    private var subject: SubjectModel = SubjectModel()
    
    // MARK: UI Properties
    
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
    
    private let dividerView: UIView = UIGenerater.makeDividerView()
    
    private let subjectTitle: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "Subject",
            font: UIFont.systemFont(ofSize: 24),
            color: UIColor.appSecondColor!
        )
        
        return label
    }()
    
    private lazy var subjectTextView: SubjectTextView = {
        let view = SubjectTextView()
        return view
    }()
    
    private let subjectdividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appMainColor
        view.layer.opacity = 0.9
        
        return view
    }()
    
    private let vocabularyTitle: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "Vocabulary",
            font: UIFont.systemFont(ofSize: 24),
            color: UIColor.appSecondColor!
        )
        
        return label
    }()
    
    private lazy var addVocabularyButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .appMainColor
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(
            self,
            action: #selector(handleAddVocabulary(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    lazy var vocabularyCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(VocabularyCell.self, forCellWithReuseIdentifier: CellName.vocabulary)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    // MARK: Lifecycle
    
    init(user: UserModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async() {
            self.subjectTextView.becomeFirstResponder()
        }
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "New Subject"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
        
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
        
        view.addSubview(subjectTitle)
        subjectTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingRight: 8
        )
        
        view.addSubview(subjectTextView)
        subjectTextView.anchor(
            top: subjectTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 8,
            paddingLeft: 9,
            paddingRight: 8,
            height: 80
        )
        
        view.addSubview(subjectdividerView)
        subjectdividerView.anchor(
            top: subjectTextView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8,
            height: 1
        )
        
        view.addSubview(vocabularyTitle)
        vocabularyTitle.anchor(
            top: subjectdividerView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 12,
            paddingLeft: 12
        )
        
        view.addSubview(addVocabularyButton)
        addVocabularyButton.anchor(
            top: subjectdividerView.bottomAnchor,
            left: vocabularyTitle.rightAnchor,
            paddingTop: 18,
            paddingLeft: 8
        )
        
        view.addSubview(vocabularyCollectionView)
        vocabularyCollectionView.anchor(
            top: vocabularyTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 8,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        subject.vocabularies.append(VocabularyModel(canDelete: false))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextInputChange),
            name: SubjectTextView.textDidChangeNotification,
            object: nil
        )
    }
    
    // MARK: Selector
    
    @objc func handleBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func handleSave(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @objc func handleTextInputChange() {
        guard let text = subjectTextView.text else { return }
        subject.subject = text
    }
    
    @objc func handleAddVocabulary(_ sender: UIButton) {
        if subject.vocabularies.count > 9 {
            return
        }
        
        subject.vocabularies.append(VocabularyModel())
        vocabularyCollectionView.reloadData()
        vocabularyCollectionView.scrollToItem(
            at: IndexPath(item: subject.vocabularies.count - 1, section: 0),
            at: .centeredVertically,
            animated: true
        )
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


// MARK: UICollectionViewDataSource

extension SubjectAddViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subject.vocabularies.count
    }
    
}


// MARK: UICollectionViewDataSource

extension SubjectAddViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellName.vocabulary, for: indexPath) as! VocabularyCell

        cell.index = indexPath.row
        cell.vocabulary = subject.vocabularies[indexPath.row]
        cell.delegate = self
        
        return cell
    }
}


// MARK: UICollectionViewDelegate

extension SubjectAddViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 12, height: 126)
    }
}


// MARK: VocabularyCellDelegate

extension SubjectAddViewController: VocabularyCellDelegate {
    func handleDeleteVocabulary(withIndex index: Int) {
        subject.vocabularies.remove(at: index)
        vocabularyCollectionView.reloadData()
    }

    func handleChangeVocabulary(withIndex index: Int, vocabulary: String) {
        subject.vocabularies[index].vocabulary = vocabulary
        vocabularyCollectionView.reloadData()
    }
    
    func handleChangeVocabularyKind(withIndex index: Int, vocabularyKind: String) {
        subject.vocabularies[index].vocabularyKind = vocabularyKind
        vocabularyCollectionView.reloadData()
    }
}
