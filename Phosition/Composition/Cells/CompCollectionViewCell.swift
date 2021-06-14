//
//  CompCollectionViewCell.swift
//  Phosition
//
//  Created by Kenneth J on 14/06/21.
//

import UIKit

class CompCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var compView: UIView!
    @IBOutlet weak var compImage: UIImageView!
    @IBOutlet weak var compTitle: UILabel!
    @IBOutlet weak var compDesc: UILabel!
    @IBOutlet weak var startButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        startButton.layer.cornerRadius = 20
    }

}
