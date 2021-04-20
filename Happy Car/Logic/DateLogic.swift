//
//  DateLogic.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/15/21.
//

import Foundation



class DateLogic {
    
    
    func timeBetween(_ now: Date, and expiration: Date) -> String {
        
        var timeDiff = Calendar.current.dateComponents(
            [
                Calendar.Component.year,
                Calendar.Component.month,
                Calendar.Component.day,
            ],
            from: now, to: expiration)
        
        // makes due tomorrow = due in one day
        timeDiff.day = Calendar.current.numberOfDaysBetween(now, and: expiration)
        
        return formatTimeBetweenString(timeDiff: timeDiff)
    }
    
    
    func formatTimeBetweenString(timeDiff: DateComponents) -> String {
        
        if (timeDiff.year ?? 0) > 0 {
            
            if timeDiff.year! == 1 {
                return "Expires in \(timeDiff.year!) year"
            }
            
            return "Expires in \(timeDiff.year!) years"
            
        }else if timeDiff.month ?? 0 > 0 {
            
            if timeDiff.month! == 1 {
                return "Expires in \(timeDiff.month!) month"
            }
            
            return "Expires in \(timeDiff.month!) months"
            
        }else if (timeDiff.day ?? 0) > 0 {
            
            if timeDiff.day! == 1 {
                return "Expires in \(timeDiff.day!) day"
            }
            
            return "Expires in \(timeDiff.day!) days"
        }else if (timeDiff.day ?? 0) == 0 {
            return "Expires today"
        }
        
        
        return "Expired"
    }
}
