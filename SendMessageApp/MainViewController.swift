//
//  ViewController.swift
//  SendMessageApp
//
//  Created by chen Ivan on 2022/5/8.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var toWhoTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    var toWho: String = ""
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Greeting"
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        toWhoTextField.text = ""
        messageTextField.text = ""
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        toWho = toWhoTextField.text!
        message = messageTextField.text!
        
        if toWho != "" && message != "" {
            performSegue(withIdentifier: "toMessageView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessageView" {
            let combined = toWho + ": " + message
            let messageVC = segue.destination as! MessageViewController
            messageVC.message = combined
        }
    }
}

