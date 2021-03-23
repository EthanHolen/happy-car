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

    var vehicleName: String
    var documentsRequest: FetchRequest<Document>
    var documents: FetchedResults<Document>{documentsRequest.wrappedValue}
    
    
    @State private var showingAddDocumentScreen = false
    
    
    init(predicate: String) {
        self.vehicleName = predicate
        self.documentsRequest = FetchRequest(entity: Document.entity(), sortDescriptors: [] , predicate: NSPredicate(format: "%K == %@", #keyPath(Document.vehicle.name), predicate))
    }

    var body: some View {
        
        VStack{
            List{
                ForEach(documents, id: \.self){ document in
                    NavigationLink(
                        destination: Text(document.vehicle?.wrappedName ?? "Unknown"),
                        label: {
                            Text(document.wrappedType)
                        })
                }
                .onDelete(perform: deleteDocuments)

            }
        }
        .navigationBarTitle(vehicleName)
        .navigationBarItems(trailing: Button(action: {
            self.showingAddDocumentScreen.toggle()
        }, label: {
            Text("New Document")
        }))
        .sheet(isPresented: $showingAddDocumentScreen, content: {
            AddDocumentView(vehicleName: vehicleName).environment(\.managedObjectContext, self.moc)
        })
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
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        return NavigationView {
            VehicleView(predicate: sampleVehicle.wrappedName)
        }
        
    }
}
