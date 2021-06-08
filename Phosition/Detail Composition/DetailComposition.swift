//
//  DetailComposition.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 07/06/21.
//

import Foundation
import UIKit


enum CompositionType: String, CaseIterable {
    case ruleOfThird = "Rule of Third"
    case leadingLine = "Water"
    case ruleOfSpace = "Rule of Space"
    case goldenRation = "Golden Ratio"
    
    func getImage() -> UIImage {
        switch self {
        case .ruleOfThird:
            return #imageLiteral(resourceName: "ROT")
        case .leadingLine:
            return #imageLiteral(resourceName: "LL")
        case .ruleOfSpace:
            return #imageLiteral(resourceName: "ROS")
        default:
            return #imageLiteral(resourceName: "GR")
        }
    }
}

class DetailComposition {
    
    var name: String?
    var description: String?
    
    init(name: String?,description: String?){
        self.name = name
        self.description = description
    }
}

class CompositionInstruction {
    var number: Int?
    var description: String?
    
    init(number: Int?, description: String?){
        self.number = number
        self.description = description
    }
    
}




