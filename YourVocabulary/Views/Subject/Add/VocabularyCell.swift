//
//  VocabularyCell.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import UIKit
import DropDown

protocol VocabularyCellDelegate {
    func handleDeleteVocabulary(withIndex index: Int)
    
    func handleChangeVocabulary(withIndex index: Int, vocabulary: String)
    
    func handleChangeVocabularyKind(withIndex index: Int, vocabularyKind: String)
}

class VocabularyCell: UICollectionViewCell {
    // MARK: Data Properties
    var index: Int = 0
    var vocabulary: VocabularyModel? {
        didSet {
            configureUI()
        }
    }
    var delegate: VocabularyCellDelegate?
    
    // MARK: UI Properties
    
    private lazy var indexLabel: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "",
            font: UIFont.systemFont(ofSize: 18),
            color: UIColor.appMainColor!
        )
        
        label.layer.opacity = 0.5
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .red
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(
            self,
            action: #selector(handleDeleteVocabulary(_:)),
            for: .touchUpInside
        )
        
        return button
    }()

    private lazy var vocabularyTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "")

        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.appMainColor?.withAlphaComponent(0.1).cgColor
        textField.layer.cornerRadius = 4 / 2
        textField.addPadding(.both(20))
        textField.addTarget(
            self,
            action: #selector(handleVocabularyTextFieldChange(_:)),
            for: .editingDidEnd
        )

        return textField
    }()
    
//    private lazy var vocabularyKindButton: UIButton = {
//        let button = UIButton(type: .system)
//
//        button.setTitleColor(.appMainColor, for: .normal)
//        button.backgroundColor = UIColor.clear
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
//        button.contentHorizontalAlignment = .left
//        button.addTarget(
//            self,
//            action: #selector(handleClickVocabularyKind(_:)),
//            for: .touchUpInside
//        )
//
//        return button
//    }()
    
    private lazy var vocabularyKindDropdown: DropDown = {
        let dropDown = DropDown()
        
        var vocabularyKindList: [String] = []
        VocabularyKind.allCases.forEach { vocabularyKind in
            dropDown.dataSource.append(vocabularyKind.rawValue.uppercased())
            vocabularyKindList.append(vocabularyKind.rawValue.uppercased())
        }
        
        dropDown.cellNib = UINib(nibName: "VocabularyKindCell", bundle: nil)
        dropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? VocabularyKindCell else { return }
            cell.optionLabel.text = vocabularyKindList[index]
            cell.optionLabel.textColor = .white
        }
        
        return dropDown
    }()
    
    private lazy var vocabularyKindLabel: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "",
            font: UIFont.systemFont(ofSize: 10),
            color: UIColor.appMainColor!
        )
        label.textAlignment = .left
        
        label.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleClickVocabularyKind))
        label.addGestureRecognizer(gestureRecognizer)
        
        return label
    }()
    
    private lazy var translatorTextField: UITextField = {
        let textField = UIGenerater.makeTextField(placeholer: "Enter translator")

        textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.layer.borderColor = UIColor.appMainColor?.cgColor
        textField.layer.cornerRadius = 4 / 2
        textField.addPadding(.both(4))
        textField.addTarget(
            self,
            action: #selector(handleTranslatorTextFieldChange(_:)),
            for: .editingDidEnd
        )

        return textField
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func configureUI() {
        guard let vocabulary = vocabulary else { return }
        backgroundColor = UIColor.appSecondColor?.withAlphaComponent(0.1)
        
        addSubview(indexLabel)
        indexLabel.text = "# \(String(index + 1))"
        indexLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 24,
            paddingLeft: 12,
            width: 42
        )
        
        addSubview(deleteButton)
        deleteButton.anchor(
            top: topAnchor,
            right: rightAnchor,
            paddingTop: 24,
            paddingRight: 3,
            width: 20,
            height: 20
        )

        addSubview(vocabularyTextField)
        vocabularyTextField.text = vocabulary.vocabulary
        vocabularyTextField.anchor(
            top: topAnchor,
            left: indexLabel.rightAnchor,
            right: deleteButton.leftAnchor,
            paddingTop: 16,
            paddingLeft: 0,
            paddingRight: 16,
            height: 38
        )
        
//        addSubview(vocabularyKindButton)
//        let title = "[ \(vocabulary.vocabularyKind) ]"
//        vocabularyKindButton.setTitle(title, for: .normal)
//        vocabularyKindButton.anchor(
//            top: vocabularyTextField.bottomAnchor,
//            left: vocabularyTextField.leftAnchor,
//            paddingTop: 8,
//            paddingLeft: 12
//        )
        
        addSubview(vocabularyKindLabel)
        let title = "[ \(vocabulary.vocabularyKind) ]"
        vocabularyKindLabel.text = title
        vocabularyKindLabel.anchor(
            top: vocabularyTextField.bottomAnchor,
            left: vocabularyTextField.leftAnchor,
            paddingTop: 8,
            paddingLeft: 0
        )
        
        vocabularyKindDropdown.anchorView = vocabularyKindLabel
        vocabularyKindDropdown.width = 200
        vocabularyKindDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            let title = "[ \(item) ]"
            
            self.vocabularyKindLabel.text = title
            self.vocabulary?.vocabularyKind = item
            self.delegate?.handleChangeVocabularyKind(withIndex: self.index, vocabularyKind: item)
        }
        
        addSubview(translatorTextField)
        translatorTextField.text = ""
        translatorTextField.anchor(
            top: vocabularyKindLabel.bottomAnchor,
            left: vocabularyKindLabel.leftAnchor,
            bottom: bottomAnchor,
            right: vocabularyTextField.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 8,
            paddingRight: 0,
            height: 28
        )
        
        if !vocabulary.canDelete {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }
    
    // MARK: Selector
    
    @objc func handleDeleteVocabulary(_ sender: UIButton) {
        delegate?.handleDeleteVocabulary(withIndex: index)
    }

    @objc func handleVocabularyTextFieldChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.handleChangeVocabulary(withIndex: index, vocabulary: text)
    }
    
    @objc func handleClickVocabularyKind() {
        vocabularyKindDropdown.show()
    }
    
    @objc func handleTranslatorTextFieldChange(_ sender: UITextField) {
        
    }
}
