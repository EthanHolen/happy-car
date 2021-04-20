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
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField(document.wrappedType, text: $type)
                        
                    }
                    Section{
                        DatePicker("Expiration", selection: $expiration, displayedComponents: .date)
                    }
                    Section {
                        TextField(document.wrappedNote, text: $note)
                        
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
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 3 * (60 * 60 * 24))
        sampleDocument.note = "This is a quick sample not which is probably as long as anyone will want to make one of these TBH \n hey\n hey\n hey"
        
        
        return EditDocumentView(document: sampleDocument)
    }
}
