//
//  AchievementCell.swift
//  Phosition
//
//  Created by Clara Anggraini on 08/06/21.
//

import UIKit

class AchievementCell: UICollectionViewCell {

    @IBOutlet weak var achievementIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        achievementIV.layer.cornerRadius = 10
    }
}
