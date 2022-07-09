//
//  Vocabulary.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/25.
//

import Foundation

enum VocabularyKind: String, CaseIterable {
    case noun = "noun"
    case pronoun = "pronoun"
    case verb = "verb"
    case adjective = "adjective"
    case adverb = "adverb"
    case preposition = "preposition"
    case conjunction = "conjunction"
    case interjection = "interjection"
}

struct VocabularyModel {
    var canDelete: Bool = true
    var vocabulary: String = ""
    var vocabularyKind: String = VocabularyKind.noun.rawValue.capitalized
    var translator: String = ""
}
