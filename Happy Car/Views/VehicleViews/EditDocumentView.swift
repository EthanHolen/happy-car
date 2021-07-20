//
//  EditDocumentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/13/21.
//

import SwiftUI
import CoreData

struct EditDocumentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    var document: Document
    @State private var type = ""
    @State private var expiration = Date()
    @State private var note = ""
    
    private var documentTypes = ["ID", "Insurance", "Registration"]
    
    
    init(document: Document) {
        
        self.document = document
        
        self._type = State(initialValue: document.wrappedType)
        self._expiration = State(initialValue: document.wrappedExpiration)
        self._note = State(initialValue: document.wrappedNote)
        
        let premiumActive = UserDefaults.standard.bool(forKey: "PremiumActive")
        
        if premiumActive {
            self.documentTypes = ["ID", "Insurance", "Registration", "Other..."]
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Image(systemName: "doc.plaintext.fill").font(.title2)) {
                        //                        TextField(type, text: $type)
                        
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
                    Section (header: Image(systemName: "square.and.pencil").font(.title2)){
                        TextEditor(text: $note)
                        
                    }
                    
                }
            }
            .navigationBarTitle("Edit \(document.wrappedType)")
            .navigationBarItems(trailing: Button(action: {
                // save and exit
                
                document.type = type
                document.expiration = expiration
                document.note = note
                
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
                
                NotificationManager.shared.requestAuthorization { granted in
                    if granted {
                        NotificationManager.shared.removeScheduledNotification(document: document)
                        let daysBeforeAlert = UserDefaults.standard.integer(forKey: "DaysBeforeAlert")
                        NotificationManager.shared.createDocumentNotification(document: document, numberOfDaysBefore: daysBeforeAlert)
                    }
                }
                
                
                
                
                self.presentationMode.wrappedValue.dismiss()
                
                
            }, label: {
                Text("Save")
            }))
            
        }
        
    }
}

struct EditDocumentView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        //        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleDocument = Document(context: moc)
        sampleDocument.documentID = UUID()
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 3 * (60 * 60 * 24))
        sampleDocument.note = "This is a quick sample not which is probably as long as anyone will want to make one of these TBH \n hey\n hey\n hey"
        
        
        return EditDocumentView(document: sampleDocument)
    }
}
