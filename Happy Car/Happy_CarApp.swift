//
//  Happy_CarApp.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/15/21.
//

import SwiftUI

@main
struct Happy_CarApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            
            case .background:
                print("Scene is in Background")
                persistenceController.save()
            case .inactive:
                print("Scene is in Inactive")
            case .active:
                print("Scene is in Active")
            @unknown default:
                // video link: https://www.youtube.com/watch?v=_GJlFk-Hhz8
                print("Uh oh Apple must have changed something check Happy_CarApp.swift")
            }
        }
    }
}
