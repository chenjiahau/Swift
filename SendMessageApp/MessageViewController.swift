//
//  MessageViewController.swift
//  SendMessageApp
//
//  Created by chen Ivan on 2022/5/8.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        messageLabel.text = message
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
        
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
