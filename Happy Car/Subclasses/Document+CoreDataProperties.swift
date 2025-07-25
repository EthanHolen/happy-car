//
//  Document+CoreDataProperties.swift
//  Happy Car
//
//  Created by Ethan Holen on 5/12/21.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var expiration: Date?
    @NSManaged public var note: String?
    @NSManaged public var type: String?
    @NSManaged public var documentID: UUID?
    @NSManaged public var vehicle: Vehicle?
    
    public var wrappedType: String {
        type ?? "Unknown Type"
    }
    
    public var wrappedExpiration: Date {
        expiration ?? Date()
    }
    
    public var wrappedNote: String {
        note ?? "Empty Note"
    }

}

extension Document : Identifiable {

}
