//
//  DocumentCellView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/2/21.
//

import SwiftUI
import CoreData

struct DocumentCellView: View {
    
    let document: Document
    
    var body: some View {
        
        let dl = DateLogic()
        
        
        
        HStack{
            
            
            VStack(alignment: .leading) {
                
                
                Text(document.wrappedType)
                    .font(.largeTitle)
                Text(dl.timeBetween(Date(), and: document.wrappedExpiration))
                    .font(.subheadline)
                    
            }
            Spacer()
            Text(dl.generateEmoji(score: document.score()))
                .font(.largeTitle)
            
        }
        
    }
}

struct DocumentCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleDocument = Document(context: moc)
        sampleDocument.type = "Sample Type"
        sampleDocument.expiration  = Date(timeIntervalSinceNow: 1000000)
        sampleDocument.note = "Sample Note"
        
        
        return DocumentCellView(document: sampleDocument)
    }
}
