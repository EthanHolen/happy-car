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
                    .onDelete(perform: deleteVehicles)
                
                }
                Button("FILL"){
                    
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
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            }))
            
            
        }
    }
    
    func deleteVehicles(at offsets: IndexSet)  {
        for offset in offsets  {
            
            let vehicle = vehicles[offset]
            
            moc.delete(vehicle)
        }
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
