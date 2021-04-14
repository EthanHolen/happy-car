//
//  AddDocumentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/21/21.
//

import SwiftUI

struct AddDocumentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var type = "ID"
    @State private var expiration = Date()
    @State private var note = ""
    
    var vehicleName: String
    var vehicleRequest: FetchRequest<Vehicle>
    var vehicles: FetchedResults<Vehicle>{vehicleRequest.wrappedValue}
    
    init(vehicleName: String) {
        self.vehicleName = vehicleName
        
        self.vehicleRequest = FetchRequest(entity: Vehicle.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", #keyPath(Vehicle.name), vehicleName))
    }
    
    var body: some View {
        
        let documentTypes = ["ID", "Insurance", "Registration", "Other..."]
        
        NavigationView {
            Form {
                Section {
                    
                    Picker("Document Type", selection: $type) {
                        ForEach(documentTypes, id: \.self){
                            Text($0)
                        }
                    }
                    if(type != "ID" && type != "Insurance" && type != "Registration"){

                        TextField("Document Type", text: $type)
                    }
      
                }
                
                Section{
                    DatePicker("Expiration", selection: $expiration, displayedComponents: .date)
                }
                
                Section {
                    TextArea("Note" , text: $note)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    
                }
                
            }
            .navigationBarTitle("New Document")
            .navigationBarItems(trailing: Button("Save"){
                let newDocument = Document(context: self.moc)
                newDocument.type = self.type
                newDocument.expiration = self.expiration
                newDocument.note = self.note
                
                if !vehicles.isEmpty {
                    newDocument.vehicle = vehicles[0]
                }
                
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        AddDocumentView(vehicleName: "Sample Car")
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
