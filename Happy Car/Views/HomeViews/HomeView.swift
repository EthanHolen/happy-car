//
//  ContentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/7/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Vehicle.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Vehicle.name, ascending: true)]) var vehicles:
        FetchedResults<Vehicle>
    
    @State private var showingAddVehicleScreen = false
    @State private var showingPremiumAlert = false
    

    
    
    var body: some View {
        NavigationView {
            VStack{
                if !(vehicles.isEmpty) {
                    List {
                        ForEach(vehicles, id:\.self){ vehicle in
                            
                            NavigationLink(destination: VehicleView(vehicle: vehicle).environment(\.managedObjectContext, self.moc)) {
                                
                                VehicleCellView(vehicle: vehicle)
                                
                            }
                            
                        }
                        .onDelete(perform: deleteVehicles)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    Button(action: {
                        self.showingAddVehicleScreen.toggle()
                    }, label: {
                        EmptyListButton(buttonText: "New Vehicle", imageName: "car.fill")
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    

                    
                }
                //TESTINGONLY: REMOVE THIS
                Button("FILL"){
                    
                    generateData()
                    
                }
            }
            .navigationBarTitle("Happy Car")
            .navigationBarItems(leading: NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Image(systemName: "gear")
                                            .font(.title2)
                                    }), trailing: Button(action: {
                                        
                                        let premiumActive = UserDefaults.standard.bool(forKey: "PremiumActive")

                                        if !premiumActive && vehicles.count > 0 {
                                            self.showingPremiumAlert.toggle()
                                        }else {
                                            self.showingAddVehicleScreen.toggle()
                                        }
                                        
                                        
                                    }, label: {
                                        Image(systemName: "car.fill")
                                            .font(.title2)
                                    }))
            .sheet(isPresented: $showingAddVehicleScreen
                   , content: {
                    AddVehicleView().environment(\.managedObjectContext, self.moc)
                   })
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showingPremiumAlert, content: {
            Alert(title: Text("Premium Feature"), message: Text("If you would like to keep multiple vehicles happy please purchase the premium version of this App. 😁"), dismissButton: .default(Text("Ok")))


            
        })
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
    //TESTINGONLY: REMOVE THIS
    func generateData(){
        
        let maggie  = Vehicle(context: self.moc)
        maggie.name = "Maggie"
        maggie.make = "Honda"
        maggie.model = "Accord"
        
        let maggieReg = Document(context: self.moc)
        maggieReg.type = "Registration"
        maggieReg.expiration = Date.init(timeIntervalSinceNow: 0) // 0 Days
        maggieReg.note = "reg note"
        maggieReg.vehicle = maggie
        
        let maggieIns = Document(context: self.moc)
        maggieIns.type = "Insurance"
        maggieIns.expiration = Date.init(timeIntervalSinceNow: 172800) // 2 Days
        maggieIns.note = "ins note"
        maggieIns.vehicle = maggie
        
        //-------
        let oliver  = Vehicle(context: self.moc)
        oliver.name = "Oliver"
        oliver.make = "Nissan"
        oliver.model = "Altima"
        
        let oliverReg = Document(context: self.moc)
        oliverReg.type = "Registration"
        oliverReg.expiration = Date.init(timeIntervalSinceNow: 2160000) // 25 days
        oliverReg.note = "reg note"
        oliverReg.vehicle = oliver
        
        let oliverIns = Document(context: self.moc)
        oliverIns.type = "Insurance"
        oliverIns.expiration = Date.init(timeIntervalSinceNow: 518400) // 6 Days
        oliverIns.note = "ins note"
        oliverIns.vehicle = oliver
        
        //-------
        let quincy  = Vehicle(context: self.moc)
        quincy.name = "Quincy"
        quincy.make = "Nissan"
        quincy.model = "Murano"
        
        let quincyReg = Document(context: self.moc)
        quincyReg.type = "Registration"
        quincyReg.expiration = Date.init(timeIntervalSinceNow: 4233600) // 49 days
        quincyReg.note = "reg note"
        quincyReg.vehicle = quincy
        
        let quincyIns = Document(context: self.moc)
        quincyIns.type = "Insurance"
        quincyIns.expiration = Date.init(timeIntervalSinceNow: 31536000) // 1 year
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



