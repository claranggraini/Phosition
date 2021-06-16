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
    var selectedComp: Composition?
    var selCompTitle: String?
    var capturedImg: UIImage?
    lazy var compositions = Database.shared.getCompositions()
    lazy var achievements = Database.shared.getAchievements()
    let defaults = UserDefaults.standard
    var achCount = 0
    var tabController: UITabBarController?
    
    @IBOutlet var congratulationView: CongratulationView!
    
    @IBAction func retakePhoto(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToCamera", sender: self)
    }
    
    @IBAction func usePhoto(_ sender: UIButton) {
        guard let unwrappedComp = selectedComp else {return}
        unwrappedComp.prog+=1
        Database.shared.updateDatabase()
        UIImageWriteToSavedPhotosAlbum(self.congratulationView.capturedImgIv.image!, nil, nil, nil)
        performSegue(withIdentifier: "congratsPopUpSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let defaults = UserDefaults.standard
            achCount+=1
            achievements[4].isUnlocked = true
            Database.shared.updateDatabase()
            congratulationView.capturedImgIv.image = capturedImg
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for comp in compositions{
            if comp.title == selCompTitle{
                selectedComp = comp
            }
        }
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
            defaults.bool(forKey: "isAchieving")
            
            defaults.setValue(true, forKey: "isAchieving")
            
            return "You have unlocked \(achCount) achievement\nYour photo is saved in Photos"
        }else{
            defaults.setValue(false, forKey: "isAchieving")
        }
        return "You have sucessfully completed the task\nYour photo is saved in Photos"
    }
    
    func validateAchievement(){
        let defaults = UserDefaults.standard
        let firstTime = defaults.bool(forKey: "firstTime")
        achCount = defaults.integer(forKey: "notifsCount")
        if !firstTime{
            defaults.set(true, forKey: "firstTime")
            achCount+=1
            achievements[4].isUnlocked = true
            Database.shared.updateDatabase()
        }
        guard let unwrappedComp = selectedComp else {return}
        
        if unwrappedComp.prog == 1{
            achCount+=1
            if unwrappedComp.title == compType.rot.rawValue{
                achievements[0].isUnlocked = true
            }else if unwrappedComp.title == compType.ll.rawValue{
                achievements[1].isUnlocked = true
            }else if unwrappedComp.title == compType.ros.rawValue{
                achievements[2].isUnlocked = true
            }else if unwrappedComp.title == compType.gr.rawValue{
                achievements[3].isUnlocked = true
            }
            Database.shared.updateDatabase()
            
        }
        let unseenAchCount = defaults.integer(forKey: "notifCount")
        var totalAch = achCount+unseenAchCount
        
        defaults.set(totalAch, forKey: "notifCount")
        if countUnlockedAchievement(){
            achievements[5].isUnlocked = true
            achievements[6].isUnlocked = true
            achCount+=2
            totalAch+=2
        }
        if achievements[6].isUnlocked && unseenAchCount == 0{
            totalAch = 0
        }
        if totalAch > 0 {
            tabController?.tabBar.items![1].badgeValue = String(totalAch)
        }
    }
    func countUnlockedAchievement()->Bool{
        var count = 0
        for ach in achievements{
            if ach.isUnlocked == true{
                count+=1
            }
        }
        if count == 5{
            return true
        }
        return false
    }
}
