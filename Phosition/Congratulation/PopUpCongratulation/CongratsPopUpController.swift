//
//  CongratsPopUpController.swift
//  Phosition
//
//  Created by Clara Anggraini on 10/06/21.
//

import UIKit

class CongratsPopUpController: UIViewController {

    @IBOutlet weak var congratsPopUpView: CongratsPopUpView!
    @IBAction func nextCourse(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToDetailComp", sender: self)
    }
    var congratsVC: CongratulationController?
    var congratsMsg = ""
    @IBAction func goToAchievement(_ sender: UIButton) {
       performSegue(withIdentifier: "unwindToAch", sender: self)
    }
    private var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        congratsPopUpView.setup()
        congratsPopUpView.congratsIV.image = UIImage.animatedImage(with: images, duration: 2)
        congratsPopUpView.congratsDescLbl.text = congratsMsg
    }
    
}
