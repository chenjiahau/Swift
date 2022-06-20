//
//  Container.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import UIKit

struct UIGenerater {
    
    static func makeTextField(placeholer: String, isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = placeholer
        textField.autocapitalizationType = .none
        textField.textColor = .appMainColor
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.isSecureTextEntry = isSecureTextEntry
        
        return textField
    }
    
    static func makeInputContainer(systemName: String, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.tintColor = .appMainColor
        imageView.image = UIImage(systemName: systemName)
        imageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 12,
            paddingLeft: 8,
            width: 24,
            height: 24
        )
        
        view.addSubview(textField)
        textField.anchor(
            top: view.topAnchor,
            left: imageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 14,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        let dividerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .appMainColor
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            return view
        }()
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        return view
    }
    
    static func makeSubmitButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appMainColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        return button
    }
    
    static func makeGotoButton(firstSentence: String, secondSentence: String) -> UIButton {
        let button = UIButton(type: .system )
        
        let attributedTitle = NSMutableAttributedString(
            string: firstSentence,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.appMainColor!
            ]
        )
        attributedTitle.append(
            NSMutableAttributedString(
                string: secondSentence,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.appMainColor!
                ]
            )
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
