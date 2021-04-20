//
//  DocumentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/27/21.
//

import SwiftUI
import CoreData

struct DocumentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State private var showingEditDocumentScreen = false
    
    let document: Document
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            HStack {
                
                Text(DateLogic().timeBetween(Date(), and: document.wrappedExpiration))
                    .font(.title)
                    .padding(5)
                    .background(document.color())
                    .cornerRadius(20)
                
                Spacer()
                
                Text(document.emoji())
                    .font(.largeTitle)
            }
            .padding(.bottom)
            
            Text(document.wrappedExpiration, style: .date)
                .font(.headline)
                .padding(.leading)
            
            //            Spacer()
            
            
            VStack (alignment: .leading) {
                Text(document.wrappedNote)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray3))
            .cornerRadius(20)
            //            Spacer()
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle(document.wrappedType)
        .alert(isPresented: $showingDeleteAlert){
            Alert(title: Text("Delete document"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")){
                self.deleteDocument()
            }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Menu {
            

            Button {
                showingEditDocumentScreen = true
            } label: {
                Label("Edit", systemImage: "square.and.pencil")
            }


            
            Button(action: {
                showingDeleteAlert = true
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
        label: {
            Image(systemName: "ellipsis")
                .font(.largeTitle)
                .padding(2)
        })
        .sheet(isPresented: $showingEditDocumentScreen, content: {

            EditDocumentView(document: document).environment(\.managedObjectContext, self.moc)
        })
        
        
        
    }
    
    func deleteDocument() {
        moc.delete(document)
        
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DocumentView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
//        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleDocument = Document(context: moc)
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 3 * (60 * 60 * 24))
        sampleDocument.note = "Simple note"
        

        return DocumentView(document: sampleDocument)

        
        
    }
}
