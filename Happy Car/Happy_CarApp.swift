//
//  Happy_CarApp.swift
//  Happy Car
//
//  Created by Ethan Holen on 2/27/21.
//

import SwiftUI

@main
struct Happy_CarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Homepage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
