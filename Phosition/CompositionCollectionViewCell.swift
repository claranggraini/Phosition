//
//  CompositionCollectionViewCell.swift
//  Phosition
//
//  Created by Kenneth J on 10/06/21.
//

import UIKit
import CoreData

class CompositionCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var CompImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var CompTitleLabel: UILabel!
    
    var composition: Composition! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let composition = composition {
//            CompImageView.image = composition.image
            CompTitleLabel.text = composition.title
//            backgroundColorView.backgroundColor = composition.color
        } else{
            CompImageView.image = nil
            CompTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
        
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        CompImageView.layer.cornerRadius = 10.0
        CompImageView.layer.masksToBounds = true
    }
}
