//
//  DetailCompositionDataSource+Delegate.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 09/06/21.
//

import UIKit

extension DetailCompositionController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return compositions.count
        case 1:
            return instructions.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let index = selectComposition()
            print("Controller: Description index is \(index)")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            guard let headerImage = compositions[3].header_img else {return cell}
            cell.descriptionImage.image = UIImage(named: headerImage)
            
            guard let desc = compositions[3].desc else {return cell}
            cell.descriptionTextLabel.text = desc
            
            return cell
        case 1:
            
            //TODO: -Masih Acak
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructionTableViewCell", for: indexPath) as! InstructionTableViewCell
            guard let instructionImage = instructions[indexPath.row].image else {return cell}
            cell.instructionImage.image = UIImage(named: instructionImage)
            
            cell.instructionNumberLabel.text = "Step \(indexPath.row + 1)"
            
            guard let instructionDesc = instructions[indexPath.row].desc else {return cell}
            cell.instructionDescriptionLabel.text = instructionDesc
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
            cell.label.text = ""
            cell.buttonTapCallback = {
                cell.label.text = "Practice"
            }
            return cell
            
        }
        
    }
    
}
