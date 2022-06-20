//
//  UIColor.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/18.
//

import UIKit

extension UIColor {
    
    static let appMainColor = UIColor(named: "appMainColor")
    static let appSecondColor = UIColor(named: "appSecondColor")
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

