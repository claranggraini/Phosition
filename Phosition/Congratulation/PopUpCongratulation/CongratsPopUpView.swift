//
//  CongratsPopUpView.swift
//  Phosition
//
//  Created by Clara Anggraini on 10/06/21.
//

import UIKit

class CongratsPopUpView: UIView {

    @IBOutlet weak var congratsDescLbl: UILabel!

    @IBOutlet weak var nextCourseBtn: UIButton!
    
    @IBOutlet weak var goToAchievementBtn: UIButton!
    
    @IBOutlet weak var congratsIV: UIImageView!
    
    var countAch = 0
    
    func setup(){
        self.layer.cornerRadius = 20
        congratsDescLbl.text = "You have unlocked \(countAch) achievement\nYour photo is saved on Photos"
        nextCourseBtn.layer.cornerRadius = 8
    }
}
