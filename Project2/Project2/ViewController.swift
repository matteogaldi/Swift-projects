//
//  ViewController.swift
//  Project2
//
//  Created by Matteo Galdi on 17/09/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreTapped))
        countries += ["estonia","france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }
    
    func resetGame(action: UIAlertAction! = nil) {
        score = 0
        questionsAsked = 0
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil)  {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        
        if (questionsAsked + 1) > 10 {
            let message = "You're final score is \(score)"
            let title = "Game Over"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Start over", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
        
        questionsAsked += 1
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()). You're score is: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct 😎"
            score += 1
        } else {
            title = "Nope! That was \(countries[sender.tag].uppercased()) 🤦‍♀️"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "You're score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func scoreTapped() {
        showAlert(title: "Score", message: "You're score is \(score)", actionButtonTitle: "Ok", handler: nil)
    }
    
    func showAlert(title: String, message: String, actionButtonTitle: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: handler))
        present(ac, animated: true)
    }
    

}

