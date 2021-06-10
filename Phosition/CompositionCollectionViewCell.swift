//
//  CompositionCollectionViewCell.swift
//  Phosition
//
//  Created by Kenneth J on 10/06/21.
//

import UIKit

class CompositionCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var CompImageView: UIImageView!
    @IBOutlet weak var backgroundColorVIew: UIView!
    @IBOutlet weak var CompTitleLabel: UILabel!
    
    var composition: Composition! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let composition = composition {
            CompImageView.image = composition.compImage
        }
    }
}
