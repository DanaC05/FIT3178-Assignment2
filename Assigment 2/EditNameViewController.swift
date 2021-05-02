//
//  EditNameViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit

class EditNameViewController: UIViewController {
    
    @IBOutlet weak var mealName: UITextField!
    var childMeal: Meal?
    var databaseController: DatabaseProtocol?
    @IBAction func saveChanges(_ sender: Any) {
        if mealName.text != "" {
            childMeal?.name = mealName.text
            databaseController?.tidyUp()
            navigationController?.popViewController(animated: true)
            return
        }
        
        displayMessage(title: "No Name Enetered", message: "Please enter the name of the meal", action: nil)
    }
    
    override func viewDidLoad() {
        // get reference to database from app delegate
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController
        
        mealName.text = childMeal?.name
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
