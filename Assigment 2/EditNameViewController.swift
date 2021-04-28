//
//  EditNameViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit

class EditNameViewController: UIViewController {
    
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var mealThumbnail: UIImageView!
    var meal: Meal?
    @IBAction func saveChanges(_ sender: Any) {
        if mealName.text != "" {
            meal?.name = mealName.text!
            navigationController?.popViewController(animated: true)
            return
        }
        
        displayMessage(title: "No Name Enetered", message: "Please enter the name of the meal")
    }
    
    override func viewDidLoad() {
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
