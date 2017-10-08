//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-05.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var completionView: UIView!
    
    @IBOutlet weak var goalDescLabel: UILabel!
    
    @IBOutlet weak var goalTypeLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    func configureCell(goal: Goal) {
        self.goalDescLabel.text = goal.goalDescription
        self.goalTypeLabel.text = goal.goalType
        self.progressLabel.text = String(describing: goal.goalProgressValue)
        
        if goal.goalProgressValue == goal.goalCompletetionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}
