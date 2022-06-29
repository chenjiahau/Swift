//
//  VocabularyCell.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import UIKit

protocol VocabularyCellDelegate {
    func handleDeleteVocabulary(withIndex index: Int)
}

class VocabularyCell: UICollectionViewCell {
    
    // MARK: Properties
    var index: Int = 0
    var vocabulary: Vocabulary? {
        didSet {
            configureUI()
        }
    }
    var delegate: VocabularyCellDelegate?
    
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
            paddingTop: 8,
            paddingLeft: 12
        )
        
        addSubview(deleteButton)
        deleteButton.anchor(
            top: topAnchor,
            right: rightAnchor,
            paddingTop: 8,
            paddingRight: 3,
            width: 20,
            height: 20
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
}
