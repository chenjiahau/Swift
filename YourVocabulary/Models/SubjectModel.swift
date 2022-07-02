//
//  Subject.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/18.
//

import Foundation

struct SubjectModel {
    var subject: String = ""
    var vocabularies: [VocabularyModel] = []
    var createdDate: Date = Date()
}
