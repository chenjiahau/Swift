//
//  SubjectService.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/7/7.
//

/*
    Database structure
    Subjects
    userId: String
    Subject: String
    numberOfvocabulary: Int

    Vocabulary
    subjectId: String
    vocabulary: String
*/

import Foundation
import Firebase

struct SubjectService {
    static func creatSubject(withUid uid: String, subject: String, numberOfvocabulary: Int, callback: @escaping (Error?, DatabaseReference?) -> ()) {
        let newSubject: [String: Any] = [
            "userId": uid,
            "subject": subject,
            "numberOfvocabulary": numberOfvocabulary
        ]
        
        DBRef.Subject.childByAutoId().setValue(newSubject) { (error, ref) in
            callback(error, ref)
        }
    }
    
    static func addVocabulary(withSubjectId subjectId: String, vocabularyList: [[String: Any]], callback: @escaping (Error?, DatabaseReference?) -> ()) {
        var newVocabularyList: [[String: Any]] = []
        
        for vocabulary in vocabularyList {
            newVocabularyList.append([
                "subjectId": subjectId,
                "vocabulary": vocabulary["vocabulary"] ?? "",
                "vocabularyKind": vocabulary["vocabularyKind"] ?? "",
                "translator": vocabulary["translator"] ?? ""
            ])
        }
        
        DBRef.Vocabulary.childByAutoId().setValue(newVocabularyList) { (error, ref) in
            callback(error, ref)
        }
    }
}
