//
//  EditVehicleView.swift
//  Happy Car
//
//  Created by Ethan Holen on 7/21/21.
//

import SwiftUI
import CoreData

struct EditVehicleView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var vehicle: Vehicle
    @State private var name = ""
    @State private var make = ""
    @State private var model = ""
    
    init(vehicle: Vehicle) {
        
        self.vehicle = vehicle
        
        self._name = State(initialValue: vehicle.wrappedName)
        self._make = State(initialValue: vehicle.wrappedMake)
        self._model = State(initialValue: vehicle.wrappedModel)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Image(systemName: "car.fill").font(.title2)){
                    TextField("Name (or nickname)", text: $name)
                }
                Section (header: Image(systemName: "car.2.fill").font(.title2)){
                    TextField("Make of Vehicle", text: $make)
                    TextField("Model of Vehicle", text: $model)
                }
            }
            .navigationBarTitle("Edit")
            .navigationBarItems(trailing: Button("Save"){
                
                vehicle.name = name
                vehicle.make = make
                vehicle.model = model
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
                
                NotificationManager.shared.requestAuthorization { granted in
                    if granted {
                        
                        for document in vehicle.documentArray {
                            NotificationManager.shared.removeScheduledNotification(document: document)
                            let daysBeforeAlert = UserDefaults.standard.integer(forKey: "DaysBeforeAlert")
                            NotificationManager.shared.createDocumentNotification(document: document, numberOfDaysBefore: daysBeforeAlert)
                        }

                    }
                }
                
                
                
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditVehicleView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.vehicleID = UUID()
        sampleVehicle.name = "Name"
        sampleVehicle.make = "Make"
        sampleVehicle.model = "Model"
        
        
        return EditVehicleView(vehicle: sampleVehicle)
    }
}
