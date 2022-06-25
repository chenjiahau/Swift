//
//  SubjecTextView.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import UIKit

class SubjectTextView: UITextView {
    
    // MARK: Properties
    
    private let placeholderLabel1: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.layer.opacity = 0.5
        label.text = "You can write down any subject"
        
        return label
    }()
    
    private let placeholderLabel2: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.layer.opacity = 0.5
        label.text = "You've learned recently"
        
        return label
    }()
    
    private let placeholderLabel3: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.layer.opacity = 0.5
        label.text = "Or you have interested"
        
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(placeholderLabel1)
        placeholderLabel1.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 8,
            paddingLeft: 4
        )
        
        addSubview(placeholderLabel2)
        placeholderLabel2.anchor(
            top: placeholderLabel1.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 2,
            paddingLeft: 4
        )
        
        addSubview(placeholderLabel3)
        placeholderLabel3.anchor(
            top: placeholderLabel2.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 2,
            paddingLeft: 4
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextInputChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selector
    
    @objc func handleTextInputChange() {
        placeholderLabel1.isHidden = !text.isEmpty
        placeholderLabel2.isHidden = !text.isEmpty
        placeholderLabel3.isHidden = !text.isEmpty
    }
}
