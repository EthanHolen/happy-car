//
//  DocumentCellView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/2/21.
//

import SwiftUI
import CoreData

struct DocumentCellView: View {
    
    @ObservedObject var document: Document
    
    var body: some View {
        
        let dl = DateLogic()
        
        HStack{
            VStack(alignment: .leading) {
                
                
                Text(document.wrappedType)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Text(dl.timeBetween(Date(), and: document.wrappedExpiration))
                    .font(.headline)
                    .padding(.bottom, 10)
                    .foregroundColor(document.color())
                
            }
            Spacer()
            Text(document.emoji())
                .font(.system(size: 45))
            
        }
        
    }
}

struct DocumentCellView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        

        
        let sampleDocument = Document(context: moc)
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 1000000)
        sampleDocument.note = "Sample Note"
        
        
        return DocumentCellView(document: sampleDocument)
        
    }
}
