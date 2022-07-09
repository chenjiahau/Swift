//
//  UserService.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

/*
    Database structure
    Users
    email: String
    userName: String
*/

import Foundation
import Firebase

struct UserService {
    static func creatUser(withUid uid: String, values: [String: Any], callback: @escaping (Error?, DatabaseReference?) -> ()) {
        let user = DBRef.User.child(uid)
        
        user.updateChildValues(values) { (error, ref) in
            callback(error, ref)
        }
    }
    
    static func getUser(withUid uid: String, callback: @escaping (DataSnapshot?) -> ()) {
        let user = DBRef.User.child(uid)
        
        user.observeSingleEvent(of: .value) { snapshot in
            callback(snapshot)
        }
    }
}
