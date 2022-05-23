//
//  NewTodoController.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/21.
//

import UIKit

class NewTodoController: UIViewController {
    @IBOutlet weak var todoTextField: UITextField!
    
    var todoManger: TodoManager = TodoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoTextField.delegate = self
        todoTextField.becomeFirstResponder()
        
        todoManger.delegate = self
    }
    
    @IBAction func onPressAddButton(_ sender: Any) {
        if let todo = todoTextField.text, todo != "" {
            todoManger.add(todo)
        }
        
    }
    
    @IBAction func onPressCancelButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - UITextFieldDelegate

extension NewTodoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let todo = todoTextField.text, todo != "" {
            textField.resignFirstResponder()
            return true
        }
        
        return false
    }
}


//MARK: - TodoManagerDelegate

extension NewTodoController: TodoManagerDelegate {
    func didUpdateTodo(_ todo: TodoModel) {
    }
    
    func didAddTodo() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func didFailTodoWithError(error: Error) {
    }
}
