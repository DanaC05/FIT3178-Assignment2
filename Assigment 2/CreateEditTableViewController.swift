//
//  CreateEditTableViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 27/4/21.
//

import UIKit
import CoreData

class CreateEditTableViewController: UITableViewController, DatabaseListener {
    
    

    let SECTION_NAME = 1
    let SECTION_INSTRUCTIONS = 2
    let SECTION_INGREDIENTS = 3
    let SECTION_ADD = 4
    let CELL_NAME = "mealTitleCell"
    let CELL_INSTRUCTIONS = "instructionsCell"
    let CELL_INGREDIENT = "ingredientCell"
    let CELL_ADD = "addIngredientCell"
    var ingredientsList: [IngredientMeasurement] = []
    var meal: Meal?
    var childMeal: Meal?
    var newMeal: Bool = false
    weak var databaseController: DatabaseProtocol?
    @IBAction func saveMeal(_ sender: Any) {
        // nothing yet - will check if new meal and whether all is filled out
        var messageTitle: String
        var messageBody: String
        if completeForm() {
            var displayMessageAction: UIAlertAction
            
            // save child meal to child context and then to core data
            databaseController?.tidyUp()
            databaseController?.cleanUp()

            // check if meal was successfully added to library
            if let mealAdded = databaseController?.addMealToMealLibrary(meal: meal!, mealLibrary: databaseController!.myMealLibrary), mealAdded || !newMeal {
                messageTitle = "Meal Saved"
                messageBody = "\((meal?.name)!) was successfully saved to your library!"
                displayMessageAction = UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
                })
            } else {
                messageTitle = "Duplicate Meal"
                messageBody = "\((meal?.name)!) is already in your library!"
                displayMessageAction = UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
                })
            }
             
            displayMessage(title: messageTitle, message: messageBody, action: displayMessageAction)
        } else {
            messageTitle = "Incomplete Meal"
            messageBody = "Be sure to complete all fields:\n"
            
            if childMeal!.name == nil {
                messageBody += "  - Must provide a name\n"
            }
            if childMeal?.instructions == nil {
                messageBody += "  - Must provide instructions\n"
            }
            if ingredientsList.isEmpty {
                messageBody += "  - Must provide at least one ingredient"
            }
            
            displayMessage(title: messageTitle, message: messageBody, action: nil)
        }
    }
    

    override func viewDidLoad() {
        // get reference to database from app delegate
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController
        
        // create child meal
        childMeal = databaseController?.passMeal(meal: meal)
        
        // set navigation title depending on intent (edit or add) and add thumbnail
        // convert meal ingredients to an array
        if childMeal?.name != nil {
            navigationItem.title = "Edit Meal"
            ingredientsList = (childMeal?.ingredients?.allObjects as? [IngredientMeasurement])!
        }
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func onLibraryChange(storedMeals: [Meal]) {
        // no action required as the stored meals cannot be changed in this view
    }
    
    func completeForm() -> Bool {
        // check if required attributes have been set
        return childMeal?.name != nil && childMeal?.instructions != nil && ingredientsList.count > 0 ? true : false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SECTION_NAME:
            fallthrough
        case SECTION_INSTRUCTIONS:
            fallthrough
        case SECTION_ADD:
            return 1
        case SECTION_INGREDIENTS:
            return ingredientsList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case SECTION_NAME:
            return "MEAL NAME"
        case SECTION_INSTRUCTIONS:
            return "INSTRUCTIONS"
        case SECTION_INGREDIENTS:
            return "INGREDIENTS"
        default:
            return nil
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case SECTION_NAME:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath)
            titleCell.textLabel?.text = childMeal?.name
            
            return titleCell
        case SECTION_INSTRUCTIONS:
            let instructionsCell = tableView.dequeueReusableCell(withIdentifier: CELL_INSTRUCTIONS, for: indexPath)
            instructionsCell.textLabel?.text = childMeal?.instructions
            
            return instructionsCell
        case SECTION_INGREDIENTS:
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGREDIENT, for: indexPath)
            let ingredient = ingredientsList[indexPath.row]
            ingredientCell.textLabel?.text = ingredient.name
            ingredientCell.detailTextLabel?.text = ingredient.quantity
            
            return ingredientCell
        default:
            let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)
            return addCell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == SECTION_INGREDIENTS ? true : false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_INGREDIENTS {
            databaseController?.removeIngredientFromMeal(ingredient: ingredientsList[indexPath.row], meal: childMeal!)
            
            ingredientsList = (childMeal?.ingredients?.allObjects as? [IngredientMeasurement])!
            tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editNameSegue":
            let destination = segue.destination as! EditNameViewController
            destination.childMeal = childMeal
        case "editInstructionsSegue":
            let destination = segue.destination as! EditInstructionsViewController
            destination.childMeal = childMeal
        default:
            // no data is needed to be passed to destination for adding ingredients
            return
        }
    }
    


    // Override to support editing the table view.
   

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
