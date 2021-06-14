//
//  DetailCompositionView.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 09/06/21.
//

import UIKit

class DetailCompositionView: UIView {
    
    @IBOutlet weak var detailCompositionTableView: UITableView!
    @IBOutlet weak var practiceButton: UIButton!
    
    func setup() {
        practiceButton.layer.cornerRadius = 4
        
        let anib = UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(anib, forCellReuseIdentifier: "descriptionTableViewCell")
        
        let bnib = UINib(nibName: "\(InstructionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(bnib, forCellReuseIdentifier: "instructionTableViewCell")
    }
    
}
