//
//  UIViewController-YOURAUTHCATE.swift
//  lab01
//
//  Created by Dana Casella on 9/3/21.
//
import UIKit

extension UIViewController {
    func displayMessage(title: String, message: String) -> Void {
        // create alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add dismiss action to alert
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        // display the alert popup
        self.present(alertController, animated: true, completion: nil)
    }
}
