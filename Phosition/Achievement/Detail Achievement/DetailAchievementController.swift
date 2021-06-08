//
//  DetailAchievementController.swift
//  Phosition
//
//  Created by Clara Anggraini on 09/06/21.
//

import UIKit

class DetailAchievementController: UIViewController {

    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var detailAchView: DetailAchievementView!
    
    var selectedAch: Achievement?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let selectedAchUnwrapped = selectedAch else{
            return
        }
        detailAchView.setup(ach: selectedAchUnwrapped)
    }
    

}
