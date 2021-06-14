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
}
