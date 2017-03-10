//
//  TestViewController.swift
//  MyPolyglot
//
//  Created by Jason Crawford on 3/10/17.
//  Copyright © 2017 Jason Crawford. All rights reserved.
//

import UIKit
import GameplayKit

class TestViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var prompt: UILabel!
    
    var words: [String]!
    var questionCounter = 0
    var showingQuestion = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextTapped))
        words = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: words) as! [String]
        title = "TEST"
        
        stackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        stackView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //the view was shown - start asking a question now
        askQuestion()
    }
    
    func nextTapped() {
        
        //move between showing question and answer
        showingQuestion = !showingQuestion
        
        if showingQuestion {
            
            //we should be showing the question - reset!
            prepareForNextQuestion()
            
        } else {
            
            //we should be showing the answer - show it now, and set the color to green
            prompt.text = words[questionCounter].components(separatedBy: "::")[0]
            prompt.textColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
    }
    
    func askQuestion() {
        
        //move the question counter one place
        questionCounter += 1
        
        if questionCounter == words.count {
            
            //wrap it back to 0 if we've gone beyond the size of the array
            questionCounter = 0
        }
        
        //pull out the french word at the current question position
        prompt.text = words[questionCounter].components(separatedBy: "::")[1]
        
        let animation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5) {
            
            self.stackView.alpha = 1
            self.stackView.transform = CGAffineTransform.identity
        }
        
        animation.startAnimation()
    }
    
    func prepareForNextQuestion() {
        
        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) { [unowned self] in
            
            self.stackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stackView.alpha = 0
        }
        
        animation.addCompletion { [unowned self] position in
            
            //reset the prompt back tp black
            self.prompt.textColor = UIColor.black
            
            //proceed with the next question
            self.askQuestion()
        }
        animation.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
