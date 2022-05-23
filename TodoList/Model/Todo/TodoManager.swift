//
//  Todo.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/22.
//

import Foundation

protocol TodoManagerDelegate {
    func didUpdateTodo(_ todo: TodoModel)
    func didAddTodo()
    func didFailTodoWithError(error: Error)
}

struct TodoManager {
    let apiURL: String = "http://localhost:8000/api/todo"
    var delegate: TodoManagerDelegate?
    
    func fetch() {
        if let url = URL(string: apiURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let todo = self.parseJSON(safeData) {
                        self.delegate?.didUpdateTodo(todo)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func add(_ todo: String) {
        if let url = URL(string: apiURL) {
            let body: [String: String] = ["todo": todo]
            let finalBody = try? JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = finalBody
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.delegate?.didAddTodo()
            }

            task.resume()
        }
    }
    
    func delete(_ timestamp: Int) {
        let apiDeleteURL = "\(apiURL)/\(timestamp)"
        if let url = URL(string: apiDeleteURL) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "DELETE"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                self.fetch()
            }

            task.resume()
        }
    }
    
    func parseJSON(_ todoData: Data) -> TodoModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TodoData.self, from: todoData)
            var todoModel = TodoModel()
            var id = 0
            
            for todo in decodedData.data {
                let todoItemModel = TodoItemModel(id: id, todo: todo.todo, timestamp: todo.timestamp)
                todoModel.list.append(todoItemModel)
                id += 1
            }
            
            return todoModel
        } catch {
            delegate?.didFailTodoWithError(error: error)
            return nil
        }
    }
}
