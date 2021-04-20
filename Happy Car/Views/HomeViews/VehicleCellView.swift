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
        HStack{
            VStack(alignment: .leading){
                Text(vehicle.wrappedName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Text(vehicle.wrappedMake + " " + vehicle.wrappedModel)
                    .font(.headline)
                    .padding(.bottom, 10)
                
            }
            Spacer()
            Text(vehicle.emoji())
                .font(.system(size: 45))
            
        }
        
    }
    
    
}

struct VehicleRowView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    static var previews: some View {
        
//        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        
        return VehicleCellView(vehicle: sampleVehicle)
    }
}
