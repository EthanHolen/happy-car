//
//  VehicleView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/14/21.
//

import SwiftUI
import CoreData

struct VehicleView: View {
    
    var vehicle: Vehicle
    
    var body: some View {
        
        VStack{
            Text(vehicle.wrappedMake)
            Text(vehicle.wrappedModel)
            List{
                ForEach(vehicle.documentArray, id: \.self){ document in
                    NavigationLink(destination: Text(document.wrappedNote)) {
                        Text(document.wrappedType)
                    }
                }
            }
        }
        .navigationBarTitle(vehicle.wrappedName)
        

    }
}

struct VehicleView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.name = "Batmobile"
        sampleVehicle.make = "BatCave"
        sampleVehicle.model = "Alfred"
        
        return NavigationView {
            VehicleView(vehicle: sampleVehicle)
//            VehicleView()
        }
        
    }
}
