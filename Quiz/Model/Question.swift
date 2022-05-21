//
//  Question.swift
//  Quiz
//
//  Created by chen Ivan on 2022/5/21.
//

import Foundation
import UIKit

struct Question {
    var activiedNumber: Int
    var list: [[String: String]]
    var score: Int
    
    init() {
        activiedNumber = 0
        score = 0
        list = [
            [
                "question": "In school, Albert Einstein failed most of the subjects, except for physics and math",
                "answer": "yes"
            ],
            [
                "question": "The first song ever sung in the space was “Happy Birthday.",
                "answer": "yes"
            ],
            [
                "question": "The first country in the world to use postcards was the United States of America.",
                "answer": "no"
            ],
            [
                "question": "A male canary tends to have a better singing voice than a female canary.",
                "answer": "yes"
            ],
            [
                "question": "Tea contains more caffeine than coffee and soda.",
                "answer": "no"
            ],
            [
                "question": "Dogs have an appendix.",
                "answer": "no"
            ],
            [
                "question": "Bill Gates is the founder of Amazon.",
                "answer": "no"
            ],
            [
                "question": "Mice have more bones than humans.",
                "answer": "yes"
            ],
            [
                "question": "John F. Kennedy is one of the four U.S. President who is on Mount Rushmore.",
                "answer": "no"
            ],
            [
                "question": "The first product with a bar code was chewing gum.",
                "answer": "yes"
            ],
        ]
        
        list.shuffle()
    }
    
    func hasQuestions() -> Bool {
        if list.count > 0 && activiedNumber < list.count {
            return true
        }
        
        return false
    }
    
    func getQuestion() -> String {
        return list[activiedNumber]["question"]!
    }
    
    mutating func checkAnswer(_ answer: String) {
        if list[activiedNumber]["answer"] == answer {
            score += 1
        }
        
        activiedNumber += 1
    }
}
