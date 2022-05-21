//
//  ViewController.swift
//  Quiz
//
//  Created by chen Ivan on 2022/5/19.
//

import UIKit

class MainController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartImage: UIImageView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var questionMode: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPressRestartImage))
        restartImage.addGestureRecognizer(gestureRecognizer)
        
        initUI()
        questionMode = Question()
        getNextQuestion()
    }
    
    func initUI() {
        scoreLabel.isHidden = true
        restartImage.isHidden = true
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        let answer = sender.titleLabel?.text!.lowercased()
        questionMode?.checkAnswer(answer!)
        getNextQuestion()
    }
    
    func getNextQuestion() {
        initUI()
        
        if let questionMode = questionMode {
            if questionMode.hasQuestions() {
                questionLabel.text = questionMode.getQuestion()
            } else {
                restartImage.isHidden = false
                yesButton.isEnabled = false
                noButton.isEnabled = false
                
                scoreLabel.text = "Your score is \(questionMode.score)"
                scoreLabel.isHidden = false
            }
        }
    }
    
    @objc func onPressRestartImage() {
        questionMode = Question()
        getNextQuestion()
    }
}

