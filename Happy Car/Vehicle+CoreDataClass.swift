//
//  Vehicle+CoreDataClass.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/27/21.
//
//

import Foundation
import CoreData

@objc(Vehicle)
public class Vehicle: NSManagedObject {
    
    
    func score() -> Int {
        
        let docCount = self.documentArray.count
        
        if docCount == 0 {
            return -100
        }

        var vehicleScore = 100
        
        for document in self.documentArray{
            let docScore = document.score()
            
            if (docScore < vehicleScore){
                vehicleScore = docScore
            }

        }
        
    
        return vehicleScore
    }
    
    
    

}
