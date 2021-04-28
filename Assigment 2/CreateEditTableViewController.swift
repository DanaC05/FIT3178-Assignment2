//
//  CreateEditTableViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 27/4/21.
//

import UIKit

class CreateEditTableViewController: UITableViewController {
    
    @IBOutlet weak var mealThumbnail: UIImageView!
    let SECTION_NAME = 0
    let SECTION_INSTRUCTIONS = 1
    let SECTION_INGREDIENTS = 2
    let SECTION_ADD = 3
    let CELL_NAME = "mealTitleCell"
    let CELL_INSTRUCTIONS = "instructionsCell"
    let CELL_INGREDIENT = "ingredientCell"
    let CELL_ADD = "addIngredientCell"
    var ingredients: [IngredientMeasurement] = []
    var meal: Meal?
    var newMeal: Bool = true
    var completeForm: Bool = false
    @IBAction func saveMeal(_ sender: Any) {
        // nothing yet - will check if new meal and whether all is filled out
    }
    

    override func viewDidLoad() {
        setDefaultMeal()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setDefaultMeal() {
        meal = Meal(name: "Breakfast Potatoes", instructions: "Before you do anything, freeze your bacon slices so when you're ready to prep, it'll be so much easier to chop! Wash the potatoes and cut into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water. In the meantime, heat the olive oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly. Once the oil is hot, drain the potatoes and add to the skillet. Season with  salt (to taste),  pepper (to taste , and  Old Bay Seasoning (to taste)  as needed. Cook for 10 minutes, stirring the potatoes often until brown. Chop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! Once the bacon is cooked, add the garlic  and toss. Season once more. Control heat as needed. Let the garlic cook until fragrant, about one minute and add fresh parsley (to taste). Just before serving, drizzle maple syrup  over the potatoes and toss. Let that cook another minute, giving the potatoes a chance to caramelize.", mealThumbnailLink: "https://d2wtgwi3o396m5.cloudfront.net/recipe/b2633ed8-3706-4c75-b321-c6702ff258a1.jpg")
        ingredients.append(IngredientMeasurement(name: "Yukon Gold Potato", quantity: "3"))
        ingredients.append(IngredientMeasurement(name: "Bacon", quantity: "2 Rashes"))
        ingredients.append(IngredientMeasurement(name: "(optional) Egg, Fried", quantity: "1"))
        
        // get image data - below code from https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
         let url = URL(string: meal!.mealThumbnailLink ?? "")!
         let mealImageData = try? Data(contentsOf: url)

         // if image data found, load into image view
         if mealImageData != nil {
            mealThumbnail.image = UIImage(data: mealImageData!)
         }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
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
            return ingredients.count
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
            if meal != nil {
                titleCell.textLabel?.text = meal!.name
            } else {
                titleCell.textLabel?.textColor = UIColor .systemGray
            }
            return titleCell
        case SECTION_INSTRUCTIONS:
            let instructionsCell = tableView.dequeueReusableCell(withIdentifier: CELL_INSTRUCTIONS, for: indexPath)
            if meal != nil {
                instructionsCell.textLabel?.text = meal!.instructions
            } else {
                instructionsCell.textLabel?.textColor = UIColor .systemGray
            }
            return instructionsCell
        case SECTION_INGREDIENTS:
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGREDIENT, for: indexPath)
            let ingredient = ingredients[indexPath.row]
            
            ingredientCell.textLabel?.text = ingredient.name
            ingredientCell.detailTextLabel?.text = ingredient.quantity
            return ingredientCell
        default:
            let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)
            return addCell
        }
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return indexPath.section == SECTION_ADD ? false : true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_INGREDIENTS {
            // Delete the row from the data source
            tableView.performBatchUpdates({
                // remove hero from current party
                self.ingredients.remove(at: indexPath.row)
                
                // delete row
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                // update sections
                self.tableView.reloadSections([SECTION_NAME, SECTION_INSTRUCTIONS, SECTION_ADD], with: .automatic)
            }, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
