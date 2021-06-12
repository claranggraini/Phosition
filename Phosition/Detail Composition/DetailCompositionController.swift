//
//  DetailCompositionController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

class DetailCompositionController: UIViewController {
    
    var selectedComposition: String = "Rule of Thirds"
    
    @IBOutlet var detailCompositionView: DetailCompositionView!

    lazy var compositions = Database.shared.getCompositions()
    lazy var instructions = Database.shared.getInstructions(from: compositions[0])
    
    var stepNo = ["Step 1", "Step 2", "Step 3", "Step 4"]
    
    var selectedIndex = 0
    var selectedInstruction:Int?
 
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let navBarSetting = UINavigationBarAppearance()
            navBarSetting.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!, .font: UIFont(name: "Raleway Thin Bold", size: 34)!]
            self.navigationController!.navigationBar.standardAppearance = navBarSetting
            self.title = selectedComposition
            
            detailCompositionView?.setup()
            detailCompositionView?.detailCompositionTableView.dataSource = self
            print("Hoho")
            
            selectedIndex = selectComposition()
            print("Controller: Selected index is \(selectedIndex)")
            
        }
    }
}

extension DetailCompositionController {
    func selectComposition() -> Int{
        let composition = selectedComposition
        
        if composition == "Rule of Thirds"{
            return 0
        } else if composition == "Leading Lines"{
            return 1
        } else if composition == "Rule of Space"{
            return 2
        } else {
            return 3
        }
    }
    
}
