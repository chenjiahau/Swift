//
//  Auth.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import Foundation
import Firebase

class AuthSerivce {
    static func createUser(withEmail email: String, password: String, callback: @escaping (AuthDataResult?, Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            callback(data, error)
        }
    }
    
    static func logUserIn(withEmail email: String, password: String, callback: @escaping (AuthDataResult?, Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
            callback(data, error)
        }
    }
}
