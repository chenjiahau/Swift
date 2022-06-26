//
//  VocabularyCell.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import UIKit

class VocabularyCell: UICollectionViewCell {
    
    // MARK: Properties
    var index: Int?
    var vocabulary: Vocabulary? {
        didSet {
            configureUI()
        }
    }
    
    private lazy var indexLabel: UILabel = {
        let label = UIGenerater.makeLabel(
            withText: "",
            font: UIFont.systemFont(ofSize: 18),
            color: UIColor.appMainColor!
        )
        
        label.layer.opacity = 0.5
        return label
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
        backgroundColor = UIColor.appSecondColor?.withAlphaComponent(0.1)
        
        addSubview(indexLabel)
        indexLabel.text = "# \(String(index! + 1))"
        indexLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 8,
            paddingLeft: 12
        )
    }
}
