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
    
    private let dl = DateLogic()
    
    var body: some View {
        
        let colors: [Int: Color] = [-1: .red, 0: .yellow, 1: .green, 2: .green]
        let docScore = document.score()


        VStack{
                Text(dl.generateEmoji(score: docScore))
                    .font(.largeTitle)
            
                Text("Expiration: \(document.wrappedExpiration, style: .date)")
                Text("Renewal: \(DateLogic().timeBetween(Date(), and: document.wrappedExpiration))")
                    .foregroundColor(colors[docScore, default: .black])

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
