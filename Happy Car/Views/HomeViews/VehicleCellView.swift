//
//  VehicleRowView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/1/21.
//

import SwiftUI
import CoreData

struct VehicleCellView: View {
    @ObservedObject var vehicle: Vehicle
    
    var body: some View {
        
        let dl = DateLogic()
        
        HStack{
            
            VStack(alignment: .leading){
                Text(vehicle.wrappedName)
                    .font(.largeTitle)
                Text(vehicle.wrappedMake + " " + vehicle.wrappedModel)
                    .font(.subheadline)
                
            }
            Spacer()
            Text(dl.generateEmoji(score: vehicle.score()))
                .font(.largeTitle)
            
            
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
        
        
        return VehicleCellView(vehicle: sampleVehicle)
    }
}
