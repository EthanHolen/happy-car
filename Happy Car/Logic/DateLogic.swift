//
//  DateLogic.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/28/21.
//

import Foundation


class DateLogic {
    
    
    func timeBetween(_ now: Date, and expiration: Date) -> String {
        
        let timeDiff = Calendar.current.dateComponents(
            [
                Calendar.Component.year,
                Calendar.Component.month,
                Calendar.Component.day,
            ],
            from: now, to: expiration)
        
        return formatTimeBetweenString(timeDiff: timeDiff)
    }
    
    
    func formatTimeBetweenString(timeDiff: DateComponents) -> String {
        
        if (timeDiff.year ?? 0) > 0 {
            
            if timeDiff.year! == 1 {
                return "\(timeDiff.year!) year"
            }
            
            return "\(timeDiff.year!) years"
            
        }else if timeDiff.month ?? 0 > 0 {
            
            if timeDiff.month! == 1 {
                return "\(timeDiff.month!) month"
            }
            
            return "\(timeDiff.month!) months"
            
        }else if (timeDiff.day ?? 0) > 0 {
            
            if timeDiff.day! == 1 {
                return "\(timeDiff.day!) day"
            }
            
            return "\(timeDiff.day!) days"
        }
        
        return "Expired"
    }
    
    
    func documentScore(expiration: Date) -> Int{
        
        var score = 0
        
        let daysUntilExpiration = Calendar.current.numberOfDaysBetween(Date(), and: expiration)
        
        if daysUntilExpiration > 14 {
            score = 2
        }
        
        if daysUntilExpiration > 7 && daysUntilExpiration <= 14 {
            score = 1
        }
        
        if daysUntilExpiration > 0 && daysUntilExpiration <= 7 {
            score = 0
        }
        
        if daysUntilExpiration < 0 {
            score = -1
        }
        
        return score
    }
    
    func generateEmoji(score: Int) -> String{
        
        var emoji = "😕"
        
        switch score {
        
        case 2:
            emoji = "😁"
            
        case 1:
            emoji = "🙂"
            
        case 0:
            emoji = "😑"
            
        case -1:
            emoji = "😢"
            
        default:
            emoji = "😕"
        }
        
        return emoji
    }
    
    
}


