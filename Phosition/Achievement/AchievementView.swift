//
//  AchievementView.swift
//  Phosition
//
//  Created by Clara Anggraini on 08/06/21.
//

import UIKit

class AchievementView: UIView {
    @IBOutlet weak var achievementCV: UICollectionView!
    
    func setup(){
        let nibCell = UINib(nibName: "AchievementCell", bundle: nil)
        achievementCV.register(nibCell, forCellWithReuseIdentifier: "AchievementCell")
    }
}
