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
                    .onAppear {
                        NotificationManager.shared.requestAuthorization { granted in
                            if granted {
                                //TODO: Maybe put a bool here for checking notification status
                            }
                        }
                    }
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
                HStack {
                    Button("FILL"){
                        
                        generateData()
                        
                    }
                    Spacer()
                    NavigationLink(destination: NotificationListView()) {
                        Text("Notifications")
                    }
                }
                .padding()
                
                
                
            }
            .navigationBarTitle("Vehicles")
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
            
            // remove all document notifications
            for doc in vehicle.documentArray {
                NotificationManager.shared.removeScheduledNotification(document: doc)
            }
            
            moc.delete(vehicle)
        }
        
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
        
        
    }
    //TESTINGONLY: REMOVE THIS
    func generateData(){
        
        
        let daysBeforeAlert = UserDefaults.standard.integer(forKey: "DaysBeforeAlert")
        
        let maggie  = Vehicle(context: self.moc)
        maggie.vehicleID = UUID()
        maggie.name = "Maggie"
        maggie.make = "Honda"
        maggie.model = "Accord"
        
        let maggieID = Document(context: self.moc)
        maggieID.documentID = UUID()
        maggieID.type = "ID"
        maggieID.expiration = Date.init(timeIntervalSinceNow: 25 * 86400) // 25 days
        maggieID.note = "id note"
        maggieID.vehicle = maggie
        NotificationManager.shared.createDocumentNotification(document: maggieID, numberOfDaysBefore: daysBeforeAlert)
        
        let maggieReg = Document(context: self.moc)
        maggieReg.documentID = UUID()
        maggieReg.type = "Registration"
        maggieReg.expiration = Date.init(timeIntervalSinceNow: 0 * 86400) // 0 Days
        maggieReg.note = "reg note"
        maggieReg.vehicle = maggie
        NotificationManager.shared.createDocumentNotification(document: maggieReg, numberOfDaysBefore: daysBeforeAlert)
        
        let maggieIns = Document(context: self.moc)
        maggieIns.documentID = UUID()
        maggieIns.type = "Insurance"
        maggieIns.expiration = Date.init(timeIntervalSinceNow: 3 * 86400) // 3 Days
        maggieIns.note = "ins note"
        maggieIns.vehicle = maggie
        NotificationManager.shared.createDocumentNotification(document: maggieIns, numberOfDaysBefore: daysBeforeAlert)
        
        //-------
        let oliver  = Vehicle(context: self.moc)
        oliver.vehicleID = UUID()
        oliver.name = "Oliver"
        oliver.make = "Nissan"
        oliver.model = "Altima"
        
        let oliverID = Document(context: self.moc)
        oliverID.documentID = UUID()
        oliverID.type = "ID"
        oliverID.expiration = Date.init(timeIntervalSinceNow: 0) // 0 Days
        oliverID.note = "id note"
        oliverID.vehicle = oliver
        NotificationManager.shared.createDocumentNotification(document: oliverID, numberOfDaysBefore: daysBeforeAlert)
        
        let oliverReg = Document(context: self.moc)
        oliverReg.documentID = UUID()
        oliverReg.type = "Registration"
        oliverReg.expiration = Date.init(timeIntervalSinceNow: 25 * 86400) // 25 days
        oliverReg.note = "reg note"
        oliverReg.vehicle = oliver
        NotificationManager.shared.createDocumentNotification(document: oliverReg, numberOfDaysBefore: daysBeforeAlert)
        
        let oliverIns = Document(context: self.moc)
        oliverIns.documentID = UUID()
        oliverIns.type = "Insurance"
        oliverIns.expiration = Date.init(timeIntervalSinceNow: 6 * 86400) // 6 Days
        oliverIns.note = "ins note"
        oliverIns.vehicle = oliver
        NotificationManager.shared.createDocumentNotification(document: oliverIns, numberOfDaysBefore: daysBeforeAlert)
        
        //-------
        let quincy  = Vehicle(context: self.moc)
        quincy.vehicleID = UUID()
        quincy.name = "Quincy"
        quincy.make = "Nissan"
        quincy.model = "Murano"
        
        let quincyID = Document(context: self.moc)
        quincyID.documentID = UUID()
        quincyID.type = "ID"
        quincyID.expiration = Date.init(timeIntervalSinceNow: 2 * 86400) // 2 Days
        quincyID.note = "id note"
        quincyID.vehicle = quincy
        NotificationManager.shared.createDocumentNotification(document: quincyID, numberOfDaysBefore: daysBeforeAlert)
        
        let quincyReg = Document(context: self.moc)
        quincyReg.documentID = UUID()
        quincyReg.type = "Registration"
        quincyReg.expiration = Date.init(timeIntervalSinceNow: 49 * 86400) // 49 days
        quincyReg.note = "reg note"
        quincyReg.vehicle = quincy
        NotificationManager.shared.createDocumentNotification(document: quincyReg, numberOfDaysBefore: daysBeforeAlert)
        
        let quincyIns = Document(context: self.moc)
        quincyIns.documentID = UUID()
        quincyIns.type = "Insurance"
        quincyIns.expiration = Date.init(timeIntervalSinceNow: 365 * 86400) // 1 year
        quincyIns.note = "ins note"
        quincyIns.vehicle = quincy
        NotificationManager.shared.createDocumentNotification(document: quincyIns, numberOfDaysBefore: daysBeforeAlert)
        
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



