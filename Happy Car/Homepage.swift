//
//  ContentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 2/27/21.
//

import SwiftUI
import CoreData

struct Homepage: View {
    var body: some View {
        
        NavigationView {
            VStack{
                
                Text("Welcome to your happy car!")
                
            }
            .navigationBarTitle(Text("Happy Car"))
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Homepage().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
