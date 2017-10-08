//
//  FinishGoalViewController.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-06.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit
import CoreData



class FinishGoalViewController: UIViewController {
    
   
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyBoard()
       
    }
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
        
    }
    

    
    @IBAction func createButtonpressed(_ sender: Any) {
        if pointsTextField.text != "" {
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismissDetail()
      
    }
    
    //Parametrar är completion handlers, en callback som utförs när allt i save funktionen är klart
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletetionValue = Int32(pointsTextField.text!)!
        goal.goalProgressValue = Int32(0)
        
        do {
                try managedContext.save()
                print("successfully saved")
                completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}
