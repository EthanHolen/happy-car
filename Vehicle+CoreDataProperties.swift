//
//  Vehicle+CoreDataProperties.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/13/21.
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
    @NSManaged public var document: NSSet?

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
