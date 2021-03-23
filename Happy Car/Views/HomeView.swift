//
//  ContentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/7/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Vehicle.entity(), sortDescriptors: []) var vehicles:
        FetchedResults<Vehicle>
    
    @State private var showingAddVehicleScreen = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(vehicles, id:\.self){ vehicle in
                        NavigationLink(destination: VehicleView(predicate: vehicle.wrappedName).environment(\.managedObjectContext, self.moc)) {
                            Text(vehicle.wrappedName)
                        }
                    }
                    .onDelete(perform: deleteVehicles)
                }
                Button("FILL"){
                    
                    generateData()
                    
                }
            }
            .navigationBarTitle("Happy Car")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddVehicleScreen.toggle()
            }, label: {
                Text("New Vehicle")
            }))
            .sheet(isPresented: $showingAddVehicleScreen
                   , content: {
                    AddVehicleView().environment(\.managedObjectContext, self.moc)
            })
            
            
        }
    }
    
    func deleteVehicles(at offsets: IndexSet) {
        for offset in offsets {
            let vehicle = vehicles[offset]
            
            moc.delete(vehicle)
        }
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
    }
    func generateData(){
        
        let maggie  = Vehicle(context: self.moc)
        maggie.name = "Maggie"
        maggie.make = "Honda"
        maggie.model = "Accord"
        
        let maggieReg = Document(context: self.moc)
        maggieReg.type = "Registration"
        maggieReg.note = "reg note"
        maggieReg.vehicle = maggie
        
        let maggieIns = Document(context: self.moc)
        maggieIns.type = "Insurance"
        maggieIns.note = "ins note"
        maggieIns.vehicle = maggie
        
        //-------
        let oliver  = Vehicle(context: self.moc)
        oliver.name = "Oliver"
        oliver.make = "Nissan"
        oliver.model = "Altima"
        
        let oliverReg = Document(context: self.moc)
        oliverReg.type = "Registration"
        oliverReg.note = "reg note"
        oliverReg.vehicle = oliver
        
        let oliverIns = Document(context: self.moc)
        oliverIns.type = "Insurance"
        oliverIns.note = "ins note"
        oliverIns.vehicle = oliver
        
        //-------
        let quincy  = Vehicle(context: self.moc)
        quincy.name = "Quincy"
        quincy.make = "Nissan"
        quincy.model = "Murano"
        
        let quincyReg = Document(context: self.moc)
        quincyReg.type = "Registration"
        quincyReg.note = "reg note"
        quincyReg.vehicle = quincy
        
        let quincyIns = Document(context: self.moc)
        quincyIns.type = "Insurance"
        quincyIns.note = "ins note"
        quincyIns.vehicle = quincy
        
        if self.moc.hasChanges  {
            try? self.moc.save()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



