//
//  CongratulationController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

class CongratulationController: UIViewController {
    lazy var selectedComp: Composition = Database.shared.getCompositions()[0]
    
    @IBOutlet var congratulationView: CongratulationView!
    
    @IBAction func retakePhoto(_ sender: UIButton) {
    }
    
    @IBAction func usePhoto(_ sender: UIButton) {
        selectedComp.prog+=1
        
        performSegue(withIdentifier: "congratsPopUpSegue", sender: self)
    }
    
    lazy var instructions = Database.shared.getInstructions(from: selectedComp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "congratsPopUpSegue"{
            let dest = segue.destination as! CongratsPopUpController
            dest.congratsVC = self
        }
    }
}
