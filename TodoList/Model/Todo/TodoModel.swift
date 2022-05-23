//
//  TodoModel.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/22.
//

import Foundation

struct TodoModel {
    var list: [TodoItemModel] = []
}

struct TodoItemModel {
    var id: Int
    var todo: String
    var timestamp: Int
}
