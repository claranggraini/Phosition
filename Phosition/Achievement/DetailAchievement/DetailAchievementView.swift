//
//  DetailAchievementView.swift
//  Phosition
//
//  Created by Clara Anggraini on 09/06/21.
//

import UIKit

class DetailAchievementView: UIView {
    
    @IBOutlet weak var detailAchIV: UIImageView!
    @IBOutlet weak var achTitleLbl: UILabel!
    @IBOutlet weak var achDescLbl: UILabel!
    
    @IBOutlet weak var dismissBtn: UIButton!
   
    
    func setup(ach: Achievement){
 
        if ach.isUnlocked{
            detailAchIV.image = UIImage(named: ach.image!)
        }else{
            detailAchIV.image = UIImage(named: "Achievement-locked")
        }
        
        achTitleLbl.text = ach.title
        if ach.isUnlocked{
            achDescLbl.text = ach.desc
        }else{
            achDescLbl.text = ""
        }
        
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.detailAchIV.layer.shadowRadius = 3
        self.detailAchIV.layer.masksToBounds = false
        self.detailAchIV.layer.shadowColor = UIColor.black.cgColor
        self.detailAchIV.layer.shadowOpacity = 0.5
        self.detailAchIV.layer.shadowOffset = CGSize(width: 4, height: 4)
    }

}
