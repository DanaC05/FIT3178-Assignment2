//
//  MealOverviewCell.swift
//  Assigment 2
//
//  Created by Dana Casella on 26/4/21.
//

import UIKit

class MealOverviewCell: UITableViewCell {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealInstructions: UITextView!
    @IBOutlet weak var mealThumbnail: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // below from https://slicode.com/how-to-create-custom-tableview-cell-from-xib-file/
    func createCell() -> MealOverviewCell? {
        let nib = UINib(nibName: "MealOverviewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? MealOverviewCell
        
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
