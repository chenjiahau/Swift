//
//  Todo.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/22.
//

import Foundation

struct TodoData: Codable {
    let data: [TodoItemData]
}

struct TodoItemData: Codable {
    let todo: String
    let timestamp: Int
}
