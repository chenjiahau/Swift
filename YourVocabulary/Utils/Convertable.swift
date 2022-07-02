//
//  Convertable.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/20.
//

import Foundation

import Foundation

protocol Convertable: Codable {
 
}


extension Convertable {
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
 
     do {
         let encoder = JSONEncoder()
         let data = try encoder.encode(self)
         
         dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
     
        return dict
    }
}
