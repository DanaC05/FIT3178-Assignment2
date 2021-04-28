//
//  MyMealsTableViewController.swift
//  Assigment 2: Portfolio Exercises
//
//  Created by Dana Casella on 26/4/21.
//

import UIKit

class MyMealsTableViewController: UITableViewController {
    
    let SECTION_MEALS = 0
    let SECTION_COUNT = 1
    let CELL_MEAL = "mealCell"
    let CELL_COUNT = "mealCountCell"
    var savedMeals: [Meal] = []
    
    override func viewDidLoad() {
        addDefaultMeals()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func addDefaultMeals() -> Void {
        savedMeals.append(Meal(name: "Breakfast Potatoes", instructions: "Before you do anything, freeze your bacon slices so when you're ready to prep, it'll be so much easier to chop! Wash the potatoes and cut into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water. In the meantime, heat the olive oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly. Once the oil is hot, drain the potatoes and add to the skillet. Season with  salt (to taste),  pepper (to taste , and  Old Bay Seasoning (to taste)  as needed. Cook for 10 minutes, stirring the potatoes often until brown. Chop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! Once the bacon is cooked, add the garlic  and toss. Season once more. Control heat as needed. Let the garlic cook until fragrant, about one minute and add fresh parsley (to taste). Just before serving, drizzle maple syrup  over the potatoes and toss. Let that cook another minute, giving the potatoes a chance to caramelize.", mealThumbnailLink: "https://d2wtgwi3o396m5.cloudfront.net/recipe/b2633ed8-3706-4c75-b321-c6702ff258a1.jpg"))
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
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath) as! MealOverviewCell
            
            let customMealCell = mealCell.createCell()!
            let meal = savedMeals[indexPath.row]


            customMealCell.mealName?.text = meal.name
            customMealCell.mealInstructions?.text = meal.instructions
            customMealCell.mealInstructions.textContainer.lineBreakMode = .byTruncatingTail

           // get image data - below code from https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
            let url = URL(string: meal.mealThumbnailLink ?? "")!
            let mealImageData = try? Data(contentsOf: url)

            // if image data found, load into image view
            if mealImageData != nil {
                customMealCell.mealThumbnail.image = UIImage(data: mealImageData!)
            }

            return customMealCell
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
            tableView.performBatchUpdates({
                // remove hero from current party
                self.savedMeals.remove(at: indexPath.row)
                
                // delete row
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                // update sections
                self.tableView.reloadSections([SECTION_COUNT], with: .automatic)
            }, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_MEALS {
            performSegue(withIdentifier: "createEditSegue", sender: self)
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
