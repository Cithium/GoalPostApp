//
//  CreateGoalViewController.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-06.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {


    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.bindToKeyBoard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        
        goalTextView.delegate = self
        goalTextView.text = "What is your goal?"
        goalTextView.textColor = UIColor.lightGray

        
    }

    @IBAction func shortButtonPressed(_ sender: Any) {
        
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        
    }
    
    
    @IBAction func longButtonPressed(_ sender: Any) {
        goalType = .longTerm
        longTermButton.setSelectedColor()
        shortTermButton.setDeselectedColor()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalViewController = storyboard?.instantiateViewController(withIdentifier: "finishGoalViewController") as? FinishGoalViewController else { return }
            finishGoalViewController.initData(description: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(__: finishGoalViewController)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        // dismiss(animated: true, completion: nil) alla anrop på animationer måste gå enlish din extension
        
        guard let goalsViewController = storyboard?.instantiateViewController(withIdentifier: "goalsViewController") else {
            return }
        dismissDetail()
    }
    
}

extension CreateGoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
            textView.text = "What is your goal?"
            
        }
    }
}
