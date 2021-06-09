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
            return #imageLiteral(resourceName: "header-ROT") 
        case .leadingLine:
            return #imageLiteral(resourceName: "LL")
        case .ruleOfSpace:
            return #imageLiteral(resourceName: "ROS")
        default:
            return #imageLiteral(resourceName: "GR")
        }
    }
}

enum InstructionNo: String, CaseIterable {
    case step1 = "Step 1"
    case step2 = "Step 2"
    case step3 = "Step 3"
    case step4 = "Step 4"
    
    func getROTimage() -> UIImage{
        switch self {
        case .step1:
            return #imageLiteral(resourceName: "ROT-1")
        case .step2:
            return #imageLiteral(resourceName: "ROT-2")
        case .step3:
            return #imageLiteral(resourceName: "ROT-4")
        default:
            return #imageLiteral(resourceName: "ROT-4")
        }
    }
}

class DetailComposition {
    
    var compositionName: CompositionType?
    var compositionDescription: String?
    
    init(compositionName: CompositionType,compositionDescription: String?){
        self.compositionName = compositionName
        self.compositionDescription = compositionDescription
    }
    
}

class CompositionInstruction {
    var instructionNo: InstructionNo?
    var instructionDescription: String?
    
    init(instructionNo: InstructionNo, instructionDescription: String?){
        self.instructionNo = instructionNo
        self.instructionDescription = instructionDescription
    }
    
}





