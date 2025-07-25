//
//  Vehicle+CoreDataProperties.swift
//  Happy Car
//
//  Created by Ethan Holen on 5/12/21.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var vehicleID: UUID?
    @NSManaged public var note: String?
    @NSManaged public var document: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    public var wrappedMake: String {
        make ?? "Unknown Make"
    }
    public var wrappedModel: String {
        model ?? "Unknown Model"
    }
    
    public var documentArray: [Document] {
        let set = document as? Set<Document> ?? []
        
        return set.sorted {
            $0.wrappedType  < $1.wrappedType
        }
        
    }

}

// MARK: Generated accessors for document
extension Vehicle {

    @objc(addDocumentObject:)
    @NSManaged public func addToDocument(_ value: Document)

    @objc(removeDocumentObject:)
    @NSManaged public func removeFromDocument(_ value: Document)

    @objc(addDocument:)
    @NSManaged public func addToDocument(_ values: NSSet)

    @objc(removeDocument:)
    @NSManaged public func removeFromDocument(_ values: NSSet)

}

extension Vehicle : Identifiable {

}
