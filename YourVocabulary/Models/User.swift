//
//  User.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import Foundation

struct User: Convertable {
    let email: String
    let username: String
    
    static func createUser(_ value: NSDictionary?) -> User {
        let email = value?["email"] as? String ?? ""
        let username = value?["username"] as? String ?? ""
        
        return User(email: email, username: username)
    }
}
