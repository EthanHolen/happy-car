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
                Text(document.emoji())
                    .font(.system(size: 70))
                Spacer()
            }
            .padding(.bottom, 15)
            
            HStack{
                Image(systemName: "clock")
                    .font(.largeTitle)
                Text(DateLogic().timeBetween(Date(), and: document.wrappedExpiration))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(document.color())
            }
            .padding(.bottom, 20)
            
            
            HStack {
                Image(systemName: "calendar")
                    .font(.title)
                Text(document.wrappedExpiration, style: .date)
                    .font(.title)
            }
            .padding(.bottom, 10)
            
            
            HStack {
                Image(systemName: "car.fill")
                    .font(.title)
                Text(document.vehicle?.wrappedName ?? "Unknown Vehicle")
                    .font(.title)
            }
            .padding(.bottom, 10)
            
            
            if document.note != "" {
                VStack {
                    
                    HStack{
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                        Spacer()
                    }
                    .frame(alignment: .leading)
                    .padding(.bottom, 5)

                    HStack{
                        Text(document.wrappedNote)
                            .font(.title3)
                        Spacer()
                    }
                    .frame(alignment: .leading)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray3).opacity(0.7))
                .cornerRadius(10)
            } else {
                EmptyView()
            }
            
            
            
            Spacer()

        }
//        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(document.color().opacity(0.2))
        .cornerRadius(20)
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
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 120 * (60 * 60 * 24))
        sampleDocument.note = "This is a note: \nThis is some text relating to the document"
        
        return NavigationView {
            DocumentView(document: sampleDocument)
        }
        
        
        
        
    }
}
