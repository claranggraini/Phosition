//
//  Database.swift
//  Phosition
//
//  Created by Clara Anggraini on 06/06/21.
//

import Foundation
import CoreData
import UIKit

class Database{
    static let shared = Database()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var compositions: [Composition] = []
    private var instructions: [Instruction] = []
    private var achievements: [Achievement] = []
    private var congratsImages :[UIImage] = [UIImage(named: "Comp 1_0")!, UIImage(named: "Comp 1_1")!,UIImage(named: "Comp 1_2")!, UIImage(named: "Comp 1_3")!,UIImage(named: "Comp 1_4")!, UIImage(named: "Comp 1_5")!,UIImage(named: "Comp 1_6")!, UIImage(named: "Comp 1_7")!,UIImage(named: "Comp 1_8")!, UIImage(named: "Comp 1_9")!,UIImage(named: "Comp 1_10")!, UIImage(named: "Comp 1_11")!,UIImage(named: "Comp 1_12")!, UIImage(named: "Comp 1_13")!,UIImage(named: "Comp 1_14")!, UIImage(named: "Comp 1_15")!,UIImage(named: "Comp 1_16")!, UIImage(named: "Comp 1_17")!,UIImage(named: "Comp 1_18")!, UIImage(named: "Comp 1_19")!,UIImage(named: "Comp 1_20")!, UIImage(named: "Comp 1_21")!,UIImage(named: "Comp 1_22")!, UIImage(named: "Comp 1_23")!,UIImage(named: "Comp 1_24")!, UIImage(named: "Comp 1_25")!,UIImage(named: "Comp 1_26")!, UIImage(named: "Comp 1_27")!,UIImage(named: "Comp 1_28")!, UIImage(named: "Comp 1_29")!,UIImage(named: "Comp 1_30")!, UIImage(named: "Comp 1_31")!,UIImage(named: "Comp 1_32")!]
    private var congratsAchImages: [UIImage] = [UIImage(named: "CA 1_0")!, UIImage(named: "CA 1_1")!, UIImage(named: "CA 1_2")!, UIImage(named: "CA 1_3")!, UIImage(named: "CA 1_4")!, UIImage(named: "CA 1_5")!, UIImage(named: "CA 1_6")!, UIImage(named: "CA 1_7")!, UIImage(named: "CA 1_8")!, UIImage(named: "CA 1_9")!, UIImage(named: "CA 1_10")!, UIImage(named: "CA 1_11")!, UIImage(named: "CA 1_12")!, UIImage(named: "CA 1_13")!, UIImage(named: "CA 1_14")!, UIImage(named: "CA 1_15")!, UIImage(named: "CA 1_16")!, UIImage(named: "CA 1_17")!, UIImage(named: "CA 1_18")!, UIImage(named: "CA 1_19")!, UIImage(named: "CA 1_20")!, UIImage(named: "CA 1_21")!, UIImage(named: "CA 1_22")!, UIImage(named: "CA 1_23")!, UIImage(named: "CA 1_24")!, UIImage(named: "CA 1_25")!, UIImage(named: "CA 1_26")!, UIImage(named: "CA 1_27")!, UIImage(named: "CA 1_28")!, UIImage(named: "CA 1_29")!, UIImage(named: "CA 1_30")!, UIImage(named: "CA 1_31")!, UIImage(named: "CA 1_32")!]
    init(){
        
    }
    
    public func getCompositions()->[Composition]{
        do{
            self.compositions = try context.fetch(Composition.fetchRequest())
            
        }catch{
            
        }
        return compositions
    }
    
    public func getInstructions(from composition: Composition)->[Instruction]{
        instructions.removeAll()
        if let ins = composition.instruction as? Set<Instruction> {
            for j in ins {
                instructions.append(j)
            }
            instructions = instructions.sorted{ itemA, itemB in
                itemA.image! < itemB.image!
            }
        }
       
        return instructions
    }
    
    public func getAchievements()->[Achievement]{
        do{
            self.achievements = try context.fetch(Achievement.fetchRequest())
            
        }catch{
            
        }
        return achievements
    }
    
    public func updateDatabase(){
        do{
            try self.context.save()
        }catch{
            
        }
    }
    
    public func getNextCompTitle(comp_name: String)->String{
        compositions = getCompositions()
        var index = 0
        for comp in compositions{
            if comp.title == "Golden Ratio"{
                return "Golden Ratio"
            }else if comp.title == comp_name{
                guard let unwrappedCompTitle = compositions[index+1].title else {return ""}
                return unwrappedCompTitle
            }
            
            index+=1
        }
        return ""
    }
    
    public func getCongratsImages()->[UIImage]{
        return congratsImages
    }
    
    public func getCongratsAchImages()->[UIImage]{
        return congratsAchImages
    }
}
