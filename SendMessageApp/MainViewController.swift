//
//  ViewController.swift
//  SendMessageApp
//
//  Created by chen Ivan on 2022/5/8.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var toWhoTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messageImageName = "message_front"
    var toWho: String = ""
    var message: String = ""
    
    var timer = Timer()
    var changeMessageImageTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeMessageImage))
        messageImage.addGestureRecognizer(gestureRecognizer)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeMessageImage), userInfo: nil, repeats: true)
    }
    
    @objc func changeMessageImage() {
        changeMessageImageTime += 1
        
        if changeMessageImageTime == 10 {
            timer.invalidate()
        }
        
        if messageImageName == "message_front" {
            messageImageName = "message_back"
            messageImage.image = UIImage(named: "message_back")
        } else {
            messageImageName = "message_front"
            messageImage.image = UIImage(named: "message_front")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        toWhoTextField.becomeFirstResponder()
        toWhoTextField.text = ""
        messageTextField.text = ""
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        toWho = toWhoTextField.text!
        message = messageTextField.text!
        
        if toWho != "" && message != "" {
            performSegue(withIdentifier: "toMessageView", sender: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "Please fill fields completely", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "I understand", style: UIAlertAction.Style.cancel) { UIAlertAction in
                print("User understood")
            }
            alert.addAction(okButton)
            
            self.present(alert, animated: true) {
                print("Alert complete")
            }
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

