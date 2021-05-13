//
//  Vehicle+CoreDataClass.swift
//  Happy Car
//
//  Created by Ethan Holen on 5/12/21.
//
//

import Foundation
import CoreData
import SwiftUI

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
    
    
    
    func emoji() -> String{
        
        let score = self.score()
        
        var emoji = "🤔"
        
        switch score {
        
        case 2:
            emoji = "😁"
            
        case 1:
            emoji = "🙂"
            
        case 0:
            emoji = "😬"
            
        case -1:
            emoji = "😢"
            
        default:
            emoji = "🤔"
        }
        
        return emoji
    }
    
    func color() -> Color{
        
        let score = self.score()
        
        var color = Color(.black)
        
        switch score {
        
        case 2:
            color = Color(.systemGreen)
            
        case 1:
            color = Color(.systemOrange)
            
        case 0:
            color = Color(.systemYellow)
            
        case -1:
            color = Color(.systemRed)
            
        default:
            color = Color(.white)
        }
        
        return color
    }

}
