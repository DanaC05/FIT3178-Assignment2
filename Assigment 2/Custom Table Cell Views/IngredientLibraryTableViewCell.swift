//
//  IngredientLibraryTableViewCell.swift
//  Assigment 2
//
//  Created by Dana Casella on 2/5/21.
//

import UIKit

class IngredientLibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // below from https://slicode.com/how-to-create-custom-tableview-cell-from-xib-file/
        func createCell() -> IngredientLibraryTableViewCell? {
            let nib = UINib(nibName: "IngredientLibraryTableViewCell", bundle: nil)
            let cell = nib.instantiate(withOwner: self, options: nil).last as? IngredientLibraryTableViewCell
            
            return cell
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
