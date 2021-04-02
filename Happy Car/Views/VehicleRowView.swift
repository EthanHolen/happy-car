//
//  VehicleRowView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/1/21.
//

import SwiftUI
import CoreData

struct VehicleRowView: View {
    var vehicle: Vehicle
    
    var body: some View {
        
        HStack{
            Text("😁")
            VStack(alignment: .leading){
                Text(vehicle.wrappedName)
                    .font(.headline)
                Text(vehicle.wrappedMake + " " + vehicle.wrappedModel)
                    .font(.subheadline)
                
            }
            
        }
        
    }
}

struct VehicleRowView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        
        return VehicleRowView(vehicle: sampleVehicle)
    }
}
