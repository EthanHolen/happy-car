//
//  AddDocumentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/21/21.
//

import SwiftUI
import CoreData

struct AddDocumentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var type = "ID"
    @State private var expiration = Date()
    @State private var note = ""
    
    private var documentTypes = ["ID", "Insurance", "Registration"]
    
    var vehicleID: UUID
    var vehicleRequest: FetchRequest<Vehicle>
    var vehicles: FetchedResults<Vehicle>{vehicleRequest.wrappedValue}
    
    init(vehicleID: UUID) {
        self.vehicleID = vehicleID
        
        self.vehicleRequest = FetchRequest(entity: Vehicle.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", #keyPath(Vehicle.vehicleID), vehicleID as CVarArg))
        
        
        let premiumActive = UserDefaults.standard.bool(forKey: "PremiumActive")
        
        if premiumActive {
            self.documentTypes = ["ID", "Insurance", "Registration", "Other..."]
        }
    }
    
    var body: some View {
        
        
        NavigationView {
            Form {
                Section (header: Image(systemName: "doc.plaintext.fill").font(.title2)) {
                    
                    Picker("Document Type", selection: $type) {
                        ForEach(documentTypes, id: \.self){
                            Text($0)
                        }
                    }
                    if(type != "ID" && type != "Insurance" && type != "Registration"){
                        
                        
                        TextField("Document Type", text: $type)
                    }
                    
                }
                
                Section (header: Image(systemName: "calendar").font(.title2)) {
                    DatePicker("Expiration", selection: $expiration, displayedComponents: .date)
                }
                
                Section (header: Image(systemName: "square.and.pencil").font(.title2)) {
                    TextArea("Note" , text: $note)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    
                }
                
            }
            .navigationBarTitle("New Document")
            .navigationBarItems(trailing: Button("Save"){
                let newDocument = Document(context: self.moc)
                newDocument.documentID = UUID()
                newDocument.type = self.type
                newDocument.expiration = self.expiration
                newDocument.note = self.note
                
                if !vehicles.isEmpty {
                    newDocument.vehicle = vehicles[0]
                }
                
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
                
                // Create a notification for the new documents expiration
                NotificationManager.shared.requestAuthorization { granted in
                    if granted {
                        let daysBeforeAlert = UserDefaults.standard.integer(forKey: "DaysBeforeAlert")

                        NotificationManager.shared.createDocumentNotification(document: newDocument, numberOfDaysBefore: daysBeforeAlert)
                    }
                }
                
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddDocumentView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let sampleVehicle = Vehicle(context: moc)
        sampleVehicle.vehicleID = UUID()
        sampleVehicle.name = "Sample Car"
        sampleVehicle.make = "Sample Make"
        sampleVehicle.model = "Sample Model"
        
        return NavigationView{
            AddDocumentView(vehicleID: sampleVehicle.vehicleID!)
        }
        
        
    }
}



struct TextArea: View {
    private let placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        TextEditor(text: $text)
            .background(
                HStack(alignment: .top) {
                    text.isBlank ? Text(placeholder) : Text("")
                    Spacer()
                }
                .foregroundColor(Color.primary.opacity(0.25))
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 7, trailing: 0))
            )
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}
