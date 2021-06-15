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
}
