//
//  DetailCompositionController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

class DetailCompositionController: UIViewController{
    
    var selectedComposition: String?

    @IBOutlet var detailCompositionView: DetailCompositionView!

    lazy var compositions = Database.shared.getCompositions()
    var instructions: [Instruction] = []
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let navBarSetting = UINavigationBarAppearance()
            navBarSetting.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!, .font: UIFont(name: "Raleway Thin Bold", size: 34)!]
            navBarSetting.titleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!]
            self.navigationController!.navigationBar.standardAppearance = navBarSetting
            
            self.navigationController?.navigationBar.isTranslucent = false

            detailCompositionView?.setup()
            detailCompositionView?.detailCompositionTableView.dataSource = self
            detailCompositionView?.detailCompositionTableView.delegate = self
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = selectedComposition
        selectInstruction()
        let navBarApp = UINavigationBarAppearance()
        
        navBarApp.titleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!]
        self.navigationController!.navigationBar.standardAppearance = navBarApp
        
        self.detailCompositionView.detailCompositionTableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func unwindDetail(_ segue: UIStoryboardSegue){
        selectedComposition! = Database.shared.getNextCompTitle(comp_name: selectedComposition!)
    }
    @IBAction func unwindDetailfromCamera(_ segue: UIStoryboardSegue){
        
    }
}

//MARK: -Passing Data Logic
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
    
    func selectInstruction() {
        let composition = selectedComposition
        if composition == "Rule of Thirds"{
            instructions = Database.shared.getInstructions(from: compositions[0])
        } else if composition == "Leading Lines"{
            instructions = Database.shared.getInstructions(from: compositions[1])
        } else if composition == "Rule of Space"{
            instructions = Database.shared.getInstructions(from: compositions[2])
        } else {
            instructions = Database.shared.getInstructions(from: compositions[3])
        }
    }
}
