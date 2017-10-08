//
//  GoalsViewController.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-05.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    
    var goals: [Goal] = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreData()
        tableView.reloadData()
    }
    
    func fetchCoreData() {
        self.fetch {
            (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func buttonPressed(_ sender: Any) {
        //skapa instans av en viewcontroller, för att kunna genomföra animation funktioner som jag kodade
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalViewController") else {
            return }
        //denna kodrad nås om guard let var en success
        //presentDetail metoden kan även användas därför att denna klass är en UI
        presentDetail(createGoalVC)
    }
    
}


// LÄS PÅ OM DENNA SEKTIONEN, SMOOTH ANIMATION FÖR ATT TA BORT TABELL-CELL
extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgressValue < chosenGoal.goalCompletetionValue {
            chosenGoal.goalProgressValue += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress")
        } catch {
            debugPrint("Could not set progress \(error.localizedDescription)")
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return GoalCell()
        }
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    //här kan man lägga till action, lägg till eller ta bort osv. För att sen kalla sina funktioner som tar bort själva datan
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return [deleteAction, addAction]
    }
}

extension GoalsViewController {
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
      
        
        do {
           goals = try  managedContext.fetch(fetchRequest) as! [Goal]
            completion(true)
            print("Successfully fetched Data")
        } catch  {
            debugPrint("print could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        //undo manager implementera!!
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let objectToDelete = goals[indexPath.row]
        managedContext.delete(objectToDelete)
        
        
        do {
            try managedContext.save()
            print("Success remove goal")
        } catch {
            debugPrint("Could not remove \(error.localizedDescription)")
        }
        
    }
    

}












