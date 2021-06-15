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
    let defaults = UserDefaults()
    @IBAction func goToAchievement(_ sender: UIButton) {
       performSegue(withIdentifier: "unwindToAch", sender: self)
    }
    
    private var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if defaults.bool(forKey: "isAchieving") == true{
            images = Database.shared.getCongratsAchImages()
        }else{
            images = Database.shared.getCongratsImages()
        }
        
        congratsPopUpView.setup()
        if congratsVC?.selCompTitle == "Golden Ratio"{
            congratsPopUpView.nextCourseBtn.setTitle("Back to Course", for: .normal)
        }
        congratsPopUpView.congratsIV.image = UIImage.animatedImage(with: images, duration: 1)
        congratsPopUpView.congratsDescLbl.text = congratsMsg
    }
    
}
