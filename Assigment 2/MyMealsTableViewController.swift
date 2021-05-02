//
//  MyMealsTableViewController.swift
//  Assigment 2: Portfolio Exercises
//
//  Created by Dana Casella on 26/4/21.
//

import UIKit

class MyMealsTableViewController: UITableViewController, DatabaseListener {
    
    let SECTION_MEALS = 0
    let SECTION_COUNT = 1
    let CELL_MEAL = "mealCell"
    let CELL_COUNT = "mealCountCell"
    var savedMeals: [Meal] = []
    var selectedMeal: Meal?
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        // get reference to database from app delegate
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func onLibraryChange(storedMeals: [Meal]) {
        savedMeals = storedMeals
        tableView.reloadData()
    }
    
    func onIngredientChange(storedIngredients: [IngredientMeasurement]) {
        // nothing needed as ingredients are not changed on this view
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case SECTION_MEALS:
            // number of rows needed is the number of saved meals
            return savedMeals.count
        case SECTION_COUNT:
            // only one cell is needed to display the saved meal count
            return 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_MEALS {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath)
            let meal = savedMeals[indexPath.row]
            
            mealCell.textLabel?.text = meal.name
            mealCell.detailTextLabel?.text = meal.instructions

            return mealCell
        }
        
        // if count section set relevent data
        let infoCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        
        // set data for info cell
        if savedMeals.isEmpty {
            infoCell.textLabel?.text = "No saved meals. Tap + to add some."
        } else {
            infoCell.textLabel?.text = "\(savedMeals.count) stored meal/s"
        }

        return infoCell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return indexPath.section == SECTION_MEALS ? true : false
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_MEALS {
            // remove meal from library object
            databaseController?.removeMealFromMealLibrary(meal: savedMeals[indexPath.row], mealLibrary: databaseController!.myMealLibrary)
            
            // delete meal from core data
            databaseController?.deleteMeal(meal: savedMeals[indexPath.row])
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_MEALS {
            selectedMeal = savedMeals[indexPath.row]
            performSegue(withIdentifier: "editMealSegue", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMealSegue" {
            let destination = segue.destination as! CreateEditTableViewController
            destination.meal = selectedMeal
            destination.newMeal = false
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
