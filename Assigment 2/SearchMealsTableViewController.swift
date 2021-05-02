//
//  SearchMealsTableViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 27/4/21.
//

import UIKit
import CoreData

class SearchMealsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let CELL_MEAL = "mealCell"
    let SECTION_MEAL = 0
    let CELL_INFO = "mealInfoCell"
    let SECTION_INFO = 1
    var searchResults: [MealData] = []
    var selectedMeal: Meal?
    var indicator = UIActivityIndicatorView()
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get reference to database from app delegate
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController
        
        // create search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        // attach to the navigation item
        navigationItem.searchController = searchController
        
        // ensure the search bar is always visible
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // add loading indicator view
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func requestMealsNamed(_ mealName: String) {
        // create URL for api request
        var searchComponents = URLComponents()
        searchComponents.scheme = "https"
        searchComponents.host = "www.themealdb.com"
        searchComponents.path = "/api/json/v1/1/search.php"
        searchComponents.queryItems = [URLQueryItem(name: "s", value: mealName)]
        
        // check validity of url
        guard let requestURL = searchComponents.url else {
            print("Error: Invalid URL")
            return
        }
        
        // create task data
        let task = URLSession.shared.dataTask(with: requestURL) {
            (data, response, error) in
            
            // check for any errors
            if let error = error {
                print(error)
                return
            }
            
            // collect data
            do {
                // create a JSONDecoder instance to make use of the codable object
                let decoder = JSONDecoder()
                let allMealData = try decoder.decode(MealDataArray.self, from: data!)
                
                // if request is sucessfull, mealData was decoded is not empty
                if let meals = allMealData.meals {
                    self.searchResults.append(contentsOf: meals)
                }
                
                // stop loading animation (as data will have loaded)
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                
                // reload table data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print(err)
            }
        }
        
        // execute data task
        task.resume()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // clear meals and reload data
        searchResults.removeAll()
        tableView.reloadData()
        
        // guard against search bar being empty (no input)
        guard let searchText = searchBar.text?.lowercased() else {
            return
        }
        
        // call request function and show loading animation
        indicator.startAnimating()
        requestMealsNamed(searchText)
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
        if (indexPath.section == SECTION_MEAL) {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath)
            let meal = searchResults[indexPath.row]
            
            // setup cell
            mealCell.textLabel?.text = meal.name
            mealCell.detailTextLabel?.text = meal.instructions
            
            return mealCell
        }
        
        let infoCell = tableView.dequeueReusableCell(withIdentifier: CELL_INFO, for: indexPath)
        infoCell.textLabel?.text = "Not what you were looking for? Tap to add a new meal."
        
        return infoCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == SECTION_MEAL) {
            selectedMeal = databaseController!.addMeal(mealData: searchResults[indexPath.row])
        }
        performSegue(withIdentifier: "editNewMealSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CreateEditTableViewController
        destination.meal = selectedMeal
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
