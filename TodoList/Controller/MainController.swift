//
//  ViewController.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/21.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoListTable: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var todoManger: TodoManager = TodoManager()
    var todoList: [TodoItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        todoListTable.delegate = self
        todoListTable.dataSource = self
        todoListTable.register(UINib(nibName: "TodoItemCell", bundle: nil), forCellReuseIdentifier: "TodoItemCell")
        
        todoManger.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoManger.fetch()
    }
}


//MARK: - UITableViewDataSource

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! TodoItemCell
        cell.id = todoList[indexPath.row].id
        cell.todoLabel.text = todoList[indexPath.row].todo

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoManger.delete(todoList[indexPath.row].timestamp)
        }
    }
}


//MARK: - UITableViewDelegate

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoList[indexPath.row])
    }
}


//MARK: - TodoManagerDelegate

extension MainController: TodoManagerDelegate {
    func didUpdateTodo(_ todo: TodoModel) {
        DispatchQueue.main.async {
            self.todoList = todo.list
            self.todoListTable.reloadData()
            
            if self.todoList.count > 0 {
                let indexPath = IndexPath(row: self.todoList.count - 1, section: 0)
                self.todoListTable.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    func didAddTodo() {
    }
    
    func didFailTodoWithError(error: Error) {
        print(error)
    }
}
