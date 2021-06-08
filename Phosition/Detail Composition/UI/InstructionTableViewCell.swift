//
//  InstructionTableViewCell.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 07/06/21.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var instructionImage: UIImageView!
    @IBOutlet weak var instructionNumberLabel: UILabel!
    @IBOutlet weak var instructionDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
