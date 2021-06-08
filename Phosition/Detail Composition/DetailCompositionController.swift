//
//  DetailCompositionController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

class DetailCompositionController: UIViewController, UITableViewDataSource {
   
    
    @IBOutlet weak var detailCompositionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCompositionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell") as! DescriptionTableViewCell
            
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructionTableViewCell") as! InstructionTableViewCell
            
            
            return cell
        }
    }


}
