//
//  Document+CoreDataProperties.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/13/21.
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
    @NSManaged public var vehicle: Vehicle?

}

extension Document : Identifiable {

}
