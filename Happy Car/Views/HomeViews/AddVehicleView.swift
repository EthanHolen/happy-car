//
//  AddVehicleView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/20/21.
//

import SwiftUI

struct AddVehicleView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var make = ""
    @State private var model = ""
    
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
            .navigationBarTitle("New Vehicle")
            .navigationBarItems(trailing: Button("Save"){
                let newVehicle = Vehicle(context: self.moc)
                newVehicle.name = self.name
                newVehicle.make = self.make
                newVehicle.model = self.model
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView()
    }
}
