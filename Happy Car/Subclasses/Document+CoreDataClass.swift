//
//  Document+CoreDataClass.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/19/21.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Document)
public class Document: NSManagedObject {
    
    func score() -> Int{
        
        var score = 0
        
        let daysUntilExpiration = Calendar.current.numberOfDaysBetween(Date(), and: self.wrappedExpiration)
        
        if daysUntilExpiration > 30 {
            score = 2
        }
        
        if daysUntilExpiration > 7 && daysUntilExpiration <= 30 {
            score = 1
        }
        
        if daysUntilExpiration > 0 && daysUntilExpiration <= 7 {
            score = 0
        }
        
        if daysUntilExpiration <= 0 {
            score = -1
        }
        
        return score
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
            color = Color(.systemGreen)
            
        case 0:
            color = Color(.systemOrange)
            
        case -1:
            color = Color(.systemRed)
            
        default:
            color = Color(.white)
        }
        
        return color
    }
    
}
