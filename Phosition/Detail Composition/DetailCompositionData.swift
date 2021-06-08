//
//  DetailCompositionData.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 08/06/21.
//

import Foundation


struct DetailCompositionData {
    
//    var name: String?
//    var description: String?
//
    var ruleOfThirdInstruction = [
        CompositionInstruction(number: 1, description: "Choose an object that you want to take a picture of."),
        CompositionInstruction(number: 2, description: "Place the object at the center of the camera view."),
        CompositionInstruction(number: 3, description: "Move the camera horizontally to left or right, so the object will be on a third left or third right in the camera view."),
        CompositionInstruction(number: 4, description: "Adjust the horizontal view lower or higher if needed, so the object will be on a third higher or a third lower in the camera view.")
    ]
    
    
    var leadingLineInstruction = [
        CompositionInstruction(number: 1, description: "Evaluate location and time of day. Are you outdoors in nature or among skyscrapers in an urban environment? Is it late in the day? If so, the sun’s rays might cast long shadows that could be used as leading lines."),
        CompositionInstruction(number: 2, description: "Notice any natural lines. Scan the area in which you’re shooting and look for natural and manmade structures that could be positioned in the frame to create strong leading lines."),
        CompositionInstruction(number: 3, description: "Determine what your object of interest is."),
        CompositionInstruction(number: 4, description: "Choose an object that you want to take a picture of. Your location might be full of potential leading lines, but it’s up to you to determine which of them best serve your subject matter. You might be shooting along railroad tracks or among lamp posts, but unless you can line up these lines with the object of interest of your image, they will only serve to confuse the viewer."),
    ]
    
    
    var ruleOfSpaceInstruction = [
        CompositionInstruction(number: 1, description: "Choose a object that is moving, looking, or pointing."),
        CompositionInstruction(number: 2, description: "Move the camera so that the object is on the center of the camera view."),
        CompositionInstruction(number: 3, description: "Give some visual space in the front of the direction of the moving object."),
        CompositionInstruction(number: 4, description: "Combines your photo with other compositional rules."),
    ]
    
    var goldenRationInstruction = [
        CompositionInstruction(number: 1, description: "Check the scene."),
        CompositionInstruction(number: 2, description: "Position the object according to the grid overlay.")
    ]
}
