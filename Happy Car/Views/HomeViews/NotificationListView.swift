//
//  NotificationListView.swift
//  Happy Car
//
//  Created by Ethan Holen on 7/20/21.
//

import SwiftUI

struct NotificationListView: View {
    
    @StateObject private var notificationManager = NotificationManager.shared
    
    var body: some View {
        List(notificationManager.notifications, id: \.identifier) { notification in
            VStack{
                Text(notification.content.title)
                    .fontWeight(.semibold)
                Text(notification.content.body)


            }
            
            
        }
        .navigationTitle("Notifications")
        .onAppear(perform: notificationManager.reloadLocalNotifications)
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
