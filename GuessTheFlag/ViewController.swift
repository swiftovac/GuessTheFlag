//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Stefan Milenkovic on 2/20/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    var countires = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCounter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check score", style: .done, target: self, action: #selector(showScore))
        
        countires += ["estonia","france","germany","ireland","italy",
        "monaco","nigeria","poland","russia","spain","uk","us"]
        
        button1.layer.borderWidth = 1.0
        button2.layer.borderWidth = 1.0
        button3.layer.borderWidth = 1.0
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        correctAnswer = Int.random(in: 0...2)
        
        askQuestion()
    }

    
    @objc func showScore() {
        
        let sc = "\(score)"
        navigationItem.rightBarButtonItem?.title = sc
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             self.navigationItem.rightBarButtonItem?.title = "Check score"
        }
    }
    
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        if questionCounter <= 10 {
            
        
        countires.shuffle()
        
        button1.setImage(UIImage(named: countires[0]), for: .normal)
        button2.setImage(UIImage(named: countires[1]), for: .normal)
        button3.setImage(UIImage(named: countires[2]), for: .normal)
        
        title = "\(countires[correctAnswer].uppercased())"
            
        questionCounter += 1
        
        }else {
            
            let acc = UIAlertController(title: "End of quiz", message: "You finsished all 10 qusteions, with score of \(score)", preferredStyle: .alert)
            acc.addAction(UIAlertAction(title: "Reset quiz", style: .default, handler: { (action) in
                
                self.questionCounter = 0
                self.score = 0
                self.askQuestion()
            }))
            
            acc.addAction(UIAlertAction(title: "Share your score", style: .default, handler: { (action) in
                
                
                
                let vc = UIActivityViewController(activityItems: [self.score], applicationActivities: [])
                
                self.present(vc, animated: true, completion: nil)
                
                
                
            }))
            
            present(acc, animated: true, completion: nil)
            
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        var message: String
        var country: String = countires[sender.tag].uppercased()
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        
        if title == "Wrong" {
            message = "No this is flag of \(country)"
        }else {
            message = "Bravo you are right!"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Countinue", style: .default, handler: askQuestion))
        
        present(ac, animated: true, completion: nil)
        
        
    }
    
}

