//
//  Document+CoreDataClass.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/27/21.
//
//

import Foundation
import CoreData

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

}
