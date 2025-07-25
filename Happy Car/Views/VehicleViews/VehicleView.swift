//
//  VehicleView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/14/21.
//

import SwiftUI
import CoreData

enum CurrentActiveSheet: Identifiable {
    case showingAddDocumentScreen, showingEditVehicleScreen
    
    var id: Int {
        hashValue
    }
}

struct VehicleView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var activeSheet: CurrentActiveSheet?
    
    var vehicle: Vehicle
    var vehicleName: String
    var documentsRequest: FetchRequest<Document>
    var documents: FetchedResults<Document>{documentsRequest.wrappedValue}
    
    @State private var showingPremiumAlert = false
    
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        self.vehicleName = vehicle.wrappedName
        self.documentsRequest = FetchRequest(
            entity: Document.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Document.type, ascending: true)] ,
            predicate: NSPredicate(format: "%K == %@", #keyPath(Document.vehicle.vehicleID), vehicle.vehicleID! as CVarArg
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
            
            
            HStack {
                Button(action: {
                    activeSheet = .showingEditVehicleScreen
                }, label: {
                    Text("Edit")
                })
                
                Spacer()
            }
            .padding()
            
            
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
                    
                    activeSheet = .showingAddDocumentScreen
                    
                }, label: {
                    EmptyListButton(buttonText: "New Document", imageName: "doc.fill.badge.plus")
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationBarTitle(vehicleName)
        .navigationBarItems(trailing: Button(action: {
            
            let premiumActive = UserDefaults.standard.bool(forKey: "PremiumActive")
            
            if !premiumActive && documents.count >= 3 {
                self.showingPremiumAlert.toggle()
            }else{
                activeSheet = .showingAddDocumentScreen
                
            }
            
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
                .font(.title2)
        }))
        .sheet(item: $activeSheet, content: { item in
            
            switch item {
            
            case .showingEditVehicleScreen:
                EditVehicleView(vehicle: vehicle).environment(\.managedObjectContext, self.moc)
                
            case .showingAddDocumentScreen:
                AddDocumentView(vehicleID: vehicle.vehicleID!).environment(\.managedObjectContext, self.moc)
                
                
                
            }
            
            
            
        })
        //        .sheet(item: $showingEditVehicleScreen, content: {
        //            EditVehicleView(vehicle: vehicle).environment(\.managedObjectContext, self.moc)
        //        })
        .alert(isPresented: $showingPremiumAlert, content: {
            Alert(title: Text("Premium Feature"), message: Text("If you would like to store more than three documents, or add documents with custom names, please purchase the premium version of this app. 😁"), dismissButton: .default(Text("Ok")))
            
            
            
        })
    }
    
    func deleteDocuments(at offsets: IndexSet) {
        for offset in offsets {
            let document = documents[offset]
            
            NotificationManager.shared.removeScheduledNotification(document: document)
            
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
        sampleVehicle.vehicleID = UUID()
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        return NavigationView {
            VehicleView(vehicle: sampleVehicle)
        }
        
        
        
        
    }
}





