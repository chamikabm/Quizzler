//
//  ViewController.swift
//  Quizzler
//
//  Created by Chamika Bandara on 7/1/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let allQuestions = QuestionBank()
    var pickedAnswer:Bool = false
    var questionNumber:Int = 0
    var score:Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
        increaseQUestionNumber()
        nextQuestion()
    }
    
    func updateUI() {
        scoreLabel.text = "Score : \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.questions.count)"
        
        let sizeOfTheScreen = view.frame.size.width
        progressBar.frame.size.width = (sizeOfTheScreen / CGFloat(allQuestions.questions.count)) * CGFloat(questionNumber + 1)
    }
    
    func nextQuestion() {
        if questionNumber < allQuestions.questions.count {
            questionLabel.text = allQuestions.questions[questionNumber].questionString
            updateUI()
        } else {
            print("End of the questions.")
            let alert = UIAlertController(title: "Awesome!", message: "You have finished all the questions, would you like to start over?", preferredStyle: UIAlertControllerStyle.alert)
            let startOverAction = UIAlertAction(title: "Start over", style: UIAlertActionStyle.default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(startOverAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions.questions[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            print("You got the correct answer for the question \(questionNumber + 1)!!")
            score += 1
        } else {
            print("You answer is incorrect for the question \(questionNumber + 1)!!")
        }
    }
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
    }
    
    func increaseQUestionNumber() {
        questionNumber += 1
    }
}
