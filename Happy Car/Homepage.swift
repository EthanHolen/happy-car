//
//  ContentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/7/21.
//

import SwiftUI

struct Homepage: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Vehicle.entity(), sortDescriptors: []) var vehicles:
        FetchedResults<Vehicle>
    
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(vehicles, id:\.self){ vehicle in
                        NavigationLink(destination: Text(vehicle.wrappedName)) {
                            Text(vehicle.wrappedName)
                        }
                    }
                }
                Button("ADD"){
                    
                    let vehicle1  = Vehicle(context: self.moc)
                    vehicle1.name = "Maggie"
                    vehicle1.make = "Honda"
                    vehicle1.model = "Accord"
                    
                    let vehicle2  = Vehicle(context: self.moc)
                    vehicle2.name = "Oliver"
                    vehicle2.make = "Nissan"
                    vehicle2.model = "Altima"
                    
                    let vehicle3  = Vehicle(context: self.moc)
                    vehicle3.name = "Quincy"
                    vehicle3.make = "Nissan"
                    vehicle3.model = "Murano"
                    
                    if self.moc.hasChanges  {
                        try? self.moc.save()
                    }
                        
                }
            }
            .navigationBarTitle("Happy Car")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
