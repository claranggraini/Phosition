//
//  DetailCompositionDataSource+Delegate.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 09/06/21.
//

import UIKit

extension DetailCompositionController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return instructions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let index = selectComposition()
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            guard let headerImage = compositions[index].header_img else {return cell}
            cell.descriptionImage.image = UIImage(named: headerImage)
            
            guard let desc = compositions[index].desc else {return cell}
            cell.descriptionTextLabel.text = desc
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructionTableViewCell", for: indexPath) as! InstructionTableViewCell
            guard let instructionImage = instructions[indexPath.row].image else {return cell}
            cell.instructionImage.image = UIImage(named: instructionImage)
            
            cell.instructionNumberLabel.text = "Step \(indexPath.row + 1)"
            
            guard let instructionDesc = instructions[indexPath.row].desc else {return cell}
            cell.instructionDescriptionLabel.text = instructionDesc
            
            return cell
        }
    }
    
    @IBAction func button_clicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cameraSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cameraSegue" {
            if let destination = segue.destination as? CameraController {
                //TODO: Masukin Variable dari CameraController
                //destination.composition = selectedComposition ?? "Rule of Thirds"
            }
        }
    }
}
