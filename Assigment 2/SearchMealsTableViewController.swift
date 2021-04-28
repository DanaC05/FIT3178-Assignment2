//
//  SearchMealsTableViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 27/4/21.
//

import UIKit

class SearchMealsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let CELL_MEAL = "mealCell"
    let SECTION_MEAL = 0
    let CELL_INFO = "mealInfoCell"
    let SECTION_INFO = 1
    var searchResults: [Meal] = []
    
    override func viewDidLoad() {
        addDefaultMeals()
        super.viewDidLoad()

        // create search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        // attach to the navigation item
        navigationItem.searchController = searchController
        
        // ensure the search bar is always visible
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func addDefaultMeals() -> Void {
        searchResults.append(Meal(name: "Breakfast Potatoes", instructions: "Before you do anything, freeze your bacon slices so when you're ready to prep, it'll be so much easier to chop! Wash the potatoes and cut into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water. In the meantime, heat the olive oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly. Once the oil is hot, drain the potatoes and add to the skillet. Season with  salt (to taste),  pepper (to taste , and  Old Bay Seasoning (to taste)  as needed. Cook for 10 minutes, stirring the potatoes often until brown. Chop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! Once the bacon is cooked, add the garlic  and toss. Season once more. Control heat as needed. Let the garlic cook until fragrant, about one minute and add fresh parsley (to taste). Just before serving, drizzle maple syrup  over the potatoes and toss. Let that cook another minute, giving the potatoes a chance to caramelize.", mealThumbnailLink: "https://d2wtgwi3o396m5.cloudfront.net/recipe/b2633ed8-3706-4c75-b321-c6702ff258a1.jpg"))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case SECTION_MEAL:
            return searchResults.count
        case SECTION_INFO:
            return 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_MEAL {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath) as! MealOverviewCell
            let customMealCell = mealCell.createCell()!
            
            let meal = searchResults[indexPath.row]
            
            // setup cell
            customMealCell.mealName.text = meal.name
            customMealCell.mealInstructions.text = meal.instructions
            
            // get image data - below code from https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
             let url = URL(string: meal.mealThumbnailLink ?? "")!
             let mealImageData = try? Data(contentsOf: url)

             // if image data found, load into image view
             if mealImageData != nil {
                customMealCell.mealThumbnail.image = UIImage(data: mealImageData!)
             }
             
             return customMealCell
        }
        
        let infoCell = tableView.dequeueReusableCell(withIdentifier: CELL_INFO, for: indexPath)
        infoCell.textLabel?.text = "Not what you were looking for? Tap to add a new meal."
        
        return infoCell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
