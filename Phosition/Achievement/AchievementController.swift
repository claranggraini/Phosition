//
//  AchievementController.swift
//  Phosition
//
//  Created by Clara Anggraini on 05/06/21.
//

import UIKit

class AchievementController: UIViewController {
   
    @IBOutlet var achievementView: AchievementView!
    
    let achievements = Database.shared.getAchievements()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!, .font: UIFont(name: "Raleway Thin Bold", size: 34)!]
            navBarAppearance.backgroundColor = UIColor(named: "Blue")
            self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
            achievementView.setup()
            achievementView.achievementCV.delegate = self
            achievementView.achievementCV.dataSource = self
        }
          
    }
   
}
