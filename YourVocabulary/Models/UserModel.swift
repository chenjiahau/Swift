//
//  User.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import Foundation

struct UserModel: Convertable {
    let email: String
    let username: String
    
    static func createUser(_ value: NSDictionary?) -> UserModel {
        let email = value?["email"] as? String ?? ""
        let username = value?["username"] as? String ?? ""
        
        return UserModel(email: email, username: username)
    }
}
