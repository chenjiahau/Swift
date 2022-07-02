//
//  VocabularyCell.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import UIKit

protocol VocabularyCellDelegate {
    func handleDeleteVocabulary(withIndex index: Int)
    
    func handleChangeVocabulary(withIndex index: Int, vocabulary: String)
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
        textField.layer.borderColor = UIColor.appMainColor?.cgColor
        textField.layer.cornerRadius = 38 / 2
        textField.layer.borderWidth = 1
        textField.addPadding(.both(20))
        textField.addTarget(
            self,
            action: #selector(handleTextFieldChange(_:)),
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

    @objc func handleTextFieldChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.handleChangeVocabulary(withIndex: index, vocabulary: text)
    }
    
}
