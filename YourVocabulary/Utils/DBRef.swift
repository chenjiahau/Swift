//
//  DBRef.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import Foundation
import Firebase

struct DBRef {
    static let User = Database.database().reference().child("Users")
}
