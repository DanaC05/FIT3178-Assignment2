//
//  EditInstructionsViewController.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit

class EditInstructionsViewController: UIViewController {

    @IBOutlet weak var instructions: UITextView!
    @IBAction func saveChanges(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
