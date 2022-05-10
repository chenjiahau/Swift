//
//  ViewController.swift
//  CatchMe
//
//  Created by chen Ivan on 2022/5/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var animal1: UIImageView!
    @IBOutlet weak var animal2: UIImageView!
    @IBOutlet weak var animal3: UIImageView!
    @IBOutlet weak var animal4: UIImageView!
    @IBOutlet weak var animal5: UIImageView!
    @IBOutlet weak var animal6: UIImageView!
    @IBOutlet weak var animal7: UIImageView!
    @IBOutlet weak var animal8: UIImageView!
    @IBOutlet weak var animal9: UIImageView!
    @IBOutlet weak var restartGame: UIButton!
    
    var yourscores = 0
    var animalList: [UIImageView] = []
    var gameTimer = Timer()
    var hideAnimalTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalList = [animal1, animal2, animal3, animal4, animal5, animal6, animal7, animal8, animal9]
        for i in 0...8 {
            let gestureRecognizerList = UITapGestureRecognizer(target: self, action: #selector(gotMe))
            
            animalList[i].isUserInteractionEnabled = true
            animalList[i].addGestureRecognizer(gestureRecognizerList)
        }
        
        restartGame.isHidden = true
        gameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(gameover), userInfo: nil, repeats: false)
        hideAnimalTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideAnimal), userInfo: nil, repeats: true)
    }
    
    @objc func gotMe() {
        yourscores += 1
        scores.text = "\(yourscores)"
    }
    
    @objc func gameover() {
        hideAnimalTimer.invalidate()
        restartGame.isHidden = false
        
        for i in 0...8 {
            animalList[i].isHidden = true
        }
    }

    @objc func hideAnimal() {
        for i in 0...8 {
            animalList[i].isHidden = true
        }
        
        let random_index = Int(arc4random_uniform(UInt32(animalList.count - 1)))
        animalList[random_index].isHidden = false
    }
    
    @IBAction func restartGame(_ sender: Any) {
        restartGame.isHidden = true
        gameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(gameover), userInfo: nil, repeats: false)
        hideAnimalTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(hideAnimal), userInfo: nil, repeats: true)
        
        scores.text = "0"
        yourscores = 0
        
    }
}

