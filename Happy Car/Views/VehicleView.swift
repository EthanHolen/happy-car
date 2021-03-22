//
//  VehicleView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/14/21.
//

import SwiftUI
import CoreData

struct VehicleView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Document.entity(), sortDescriptors: []) var documents:
        FetchedResults<Document>
    
    var vehicleName: String
    
    var body: some View {
        
        VStack{
//            Text(vehicle.wrappedMake)
//            Text(vehicle.wrappedModel)
            List{
                ForEach(documents, id: \.self){ doc in
                    if doc.vehicle?.wrappedName == vehicleName{
                        NavigationLink(destination: Text(doc.wrappedNote)){
                            Text(doc.wrappedType)
                        }
                    }
                    
                }
                .onDelete(perform: deleteDocuments)
            }
        }
        .navigationBarTitle(vehicleName)
        .navigationBarItems(trailing: Button(action: {
            //  addDocumentView here
        }, label: {
            Text("New Document")
        }))
        

        

    }
    
    func deleteDocuments(at offsets: IndexSet) {
        for offset in offsets {
            let document = documents[offset]
            
            moc.delete(document)
        }
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
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
            VehicleView(vehicleName: sampleVehicle.wrappedName)
        }
        
    }
}
