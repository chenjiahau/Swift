//
//  ViewController.swift
//  DivisionMathApp
//
//  Created by chen Ivan on 2022/5/8.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var resultNumberLabel: UILabel!
    
    var lastValue: [String: Double] = [
        "firstNumber": 0,
        "secondNumber": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNumberTextField.text = String(lastValue["firstNumber"]!)
        secondNumberTextField.text = String(lastValue["secondNumber"]!)
        
        let firstNumber = UserDefaults.standard.object(forKey: "firstNumber")
        let secondNumber = UserDefaults.standard.object(forKey: "secondNumber")
        
        if let firstNumber = firstNumber as? Double, let secondNumber = secondNumber as? Double {
            firstNumberTextField.text = String(firstNumber)
            secondNumberTextField.text = String(secondNumber)
            
            if secondNumber != 0 {
                let resultNumber = (firstNumber / secondNumber)
                resultNumberLabel.text = String(format: "%0.6f", resultNumber)
            }
        }
    }

    @IBAction func calculateButton(_ sender: UIButton) {
        if let firstNumber = Double(firstNumberTextField.text!), let secondNumber = Double(secondNumberTextField.text!) {
            if secondNumber == 0 {
                return
            }
            
            let resultNumber = (firstNumber / secondNumber)
            resultNumberLabel.text = String(format: "%0.6f", resultNumber)
            
            UserDefaults.standard.set(firstNumber, forKey: "firstNumber")
            UserDefaults.standard.set(secondNumber, forKey: "secondNumber")
        }
    }
    
}

