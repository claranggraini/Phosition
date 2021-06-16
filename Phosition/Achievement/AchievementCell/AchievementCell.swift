//
//  AchievementCell.swift
//  Phosition
//
//  Created by Clara Anggraini on 11/06/21.
//

import UIKit

class AchievementCell: UICollectionViewCell {

    @IBOutlet weak var achievementIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        achievementIV.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
    }

}
