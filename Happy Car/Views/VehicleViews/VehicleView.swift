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

    var vehicle: Vehicle
    var vehicleName: String
    var documentsRequest: FetchRequest<Document>
    var documents: FetchedResults<Document>{documentsRequest.wrappedValue}
    
    
    @State private var showingAddDocumentScreen = false
    
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        self.vehicleName = vehicle.wrappedName
        self.documentsRequest = FetchRequest(entity: Document.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Document.type, ascending: true)] , predicate: NSPredicate(format: "%K == %@", #keyPath(Document.vehicle.name), vehicle.wrappedName
        ))
    }

    var body: some View {
        VStack {
            
            HStack {
                VStack (alignment: .leading){
                    Text(vehicle.wrappedMake)
                        .font(.title2)
                    
                    Text(vehicle.wrappedModel)
                        .font(.title)
                        .bold()
                }
                
                
                
                
                Spacer()
                
                Text(vehicle.emoji())
                    .font(.system(size: 45))
            }
            .padding(.horizontal)
//            .background(Color(.blue))
            
            
            
            
            if !(documents.isEmpty) {
                List{
                    ForEach(documents, id: \.self){ document in
                        NavigationLink(
                            destination: DocumentView(document: document),
                            label: {
                                DocumentCellView(document: document)
                            })
                    }
                    .onDelete(perform: deleteDocuments)

                }
                .listStyle(InsetGroupedListStyle())
            } else {
                Button(action: {
                    self.showingAddDocumentScreen.toggle()
                }, label: {
                    EmptyListButton(buttonText: "New Document")
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationBarTitle(vehicleName)
        .navigationBarItems(trailing: Button(action: {
            self.showingAddDocumentScreen.toggle()
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
                .font(.title2)
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

    static var previews: some View {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        return VehicleView(vehicle: sampleVehicle)
        
        
    }
}
