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
        
//        dismissBtn.layer.shadowOpacity = 1
//        dismissBtn.layer.shadowColor = UIColor.black.cgColor
//        dismissBtn.layer.shadowRadius = 2
//        dismissBtn.layer.shadowOffset = .zero
        
        detailAchIV.image = UIImage(named: ach.image!)
        achTitleLbl.text = ach.title
        achDescLbl.text = ach.desc
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
    }

}
