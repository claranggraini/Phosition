//
//  CongratulationController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

enum compType: String{
    case rot = "Rule of Thirds"
    case ll = "Leading Lines"
    case ros = "Rule of Space"
    case gr = "Golden Ratio"
}

class CongratulationController: UIViewController {
    lazy var selectedComp: Composition = Database.shared.getCompositions()[2]
    lazy var compositions = Database.shared.getCompositions()
    lazy var achievements = Database.shared.getAchievements()
    var achCount = 0
    
    @IBOutlet var congratulationView: CongratulationView!
    
    @IBAction func retakePhoto(_ sender: UIButton) {
    }
    
    @IBAction func usePhoto(_ sender: UIButton) {
        selectedComp.prog+=1
        Database.shared.updateDatabase()
        
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
            dest.congratsMsg = getAchMsg()
        }
    }
    
    func getAchMsg()->String{
        
        validateAchievement()
        if achCount > 0{
            return "You have unlocked \(achCount) achievement\nYour photo is saved in Photos"
        }
        return "You have sucessfully completed the task\nYour photo is saved in Photos"
    }
    
    func validateAchievement(){
        let defaults = UserDefaults.standard
        let firstTime = defaults.bool(forKey: "firstTime")
        if !firstTime{
            defaults.set(true, forKey: "firstTime")
            achCount+=1
            achievements[4].isUnlocked = true
            Database.shared.updateDatabase()
        }
        if selectedComp.prog == 1{
            achCount+=1
            if selectedComp.title == compType.rot.rawValue{
                achievements[0].isUnlocked = true
            }else if selectedComp.title == compType.ll.rawValue{
                achievements[1].isUnlocked = true
            }else if selectedComp.title == compType.ros.rawValue{
                achievements[2].isUnlocked = true
            }else if selectedComp.title == compType.gr.rawValue{
                achievements[3].isUnlocked = true
            }
            Database.shared.updateDatabase()
        }
    }
}
