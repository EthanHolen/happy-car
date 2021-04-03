//
//  VehicleRowView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/1/21.
//

import SwiftUI
import CoreData

struct VehicleCellView: View {
    var vehicle: Vehicle
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading){
                Text(vehicle.wrappedName)
                    .font(.largeTitle)
                Text(vehicle.wrappedMake + " " + vehicle.wrappedModel)
                    .font(.subheadline)
                
            }
            Spacer()
            Text(vehicleEmoji(vehicle: vehicle))
                .font(.largeTitle)
            
            
        }
        
    }
    
    func vehicleEmoji(vehicle: Vehicle) -> String {
        
        let docCount = vehicle.documentArray.count
        
        if docCount == 0 {
            return "😕"
        }
        
        let dl = DateLogic()
        
        var vehicleScore = 0
        
        for document in vehicle.documentArray{
            vehicleScore += dl.documentScore(expiration: document.wrappedExpiration)
        }
        
    
        return dl.generateEmoji(score: (vehicleScore / docCount))
    }
    
    
}

struct VehicleRowView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        
        return VehicleCellView(vehicle: sampleVehicle)
    }
}
