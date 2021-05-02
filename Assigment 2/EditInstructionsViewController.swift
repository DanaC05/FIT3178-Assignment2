//
//  EditInstructionsViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit

class EditInstructionsViewController: UIViewController {

    var childMeal: Meal?
    @IBOutlet weak var instructions: UITextView!
    @IBAction func saveChanges(_ sender: Any) {
        if instructions.text != "" {
            childMeal?.instructions = instructions.text
            navigationController?.popViewController(animated: true)
            return
        }
        displayMessage(title: "No Instructions Enetered", message: "Please enter the instructions for making \(childMeal?.name ?? "your meal")", action: nil)
    }
    
    override func viewDidLoad() {
        instructions.text = childMeal?.instructions
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
