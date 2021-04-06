//
//  DocumentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/27/21.
//

import SwiftUI
import CoreData

struct DocumentView: View {
    
    var document: Document
    

    
    var body: some View {
        
        VStack{
            Text(document.emoji())
                    .font(.largeTitle)
            
                Text("Expiration: \(document.wrappedExpiration, style: .date)")
                Text("Renewal: \(DateLogic().timeBetween(Date(), and: document.wrappedExpiration))")
                    .foregroundColor(document.color())

                Text(document.wrappedNote)

            }
            .navigationTitle(document.wrappedType)
            

    }
}

struct DocumentView_Previews: PreviewProvider {
    
    
    
    
    
    //        static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleDocument = Document(context: moc)
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date()
        sampleDocument.note = "Sample Note"
        
        return DocumentView(document: sampleDocument)
        
        
        
    }
}
