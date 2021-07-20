//
//  NotificationManager.swift
//  Happy Car
//
//  Created by Ethan Holen on 7/20/21.
//

import Foundation
import UserNotifications
import CoreLocation

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    @Published private(set) var notifications: [UNNotificationRequest] = []
    
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
                
                self.fetchNotificationSettings()
                completion(granted)
            }
    }
    
    
    func fetchNotificationSettings() {
        // 1
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            // 2
            DispatchQueue.main.async {
                self.settings = settings
            }
        }
    }
    
    func reloadLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications

            }
        }
    }
    
    
    func createDocumentNotification(document: Document, numberOfDaysBefore: Int) {
        
        
        let content = UNMutableNotificationContent()
        content.title = "The " + document.wrappedType + " for " + (document.vehicle?.wrappedName ?? "Unknown Vehicle") + " is looking sad! 😢"
        content.body = "It looks like " + (document.vehicle?.wrappedName ?? "Unknown Vehicle") + "s " + (document.wrappedType) + " is expiring soon!"
        
        var trigger: UNNotificationTrigger?
        
        if let date = document.expiration {
            
            // convert the numberOfDaysBefore to negative
            let negativeNumberOfDaysBefore = numberOfDaysBefore * -1
            
            print("DAYS BEFORE: \(negativeNumberOfDaysBefore)")
            
            if let modifiedDate = Calendar.current.date(byAdding: .day, value: negativeNumberOfDaysBefore, to: date) {
                
                trigger = UNCalendarNotificationTrigger(
                    dateMatching: Calendar.current.dateComponents(
                        [.day, .month, .year, .hour, .minute],
                        from: modifiedDate),
                    repeats: false)
            }
                
        }
        
        
        if let trigger = trigger {
            let request = UNNotificationRequest(
                identifier: document.documentID!.uuidString,
                content: content,
                trigger: trigger)
            // 5
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func removeScheduledNotification(document: Document) {
        
        if let documentID = document.documentID?.uuidString {
            UNUserNotificationCenter.current()
              .removePendingNotificationRequests(withIdentifiers: [documentID])
        }else{
            print("Could not get documentID from " + document.wrappedType)
        }
        
        
      
    }
    
}
