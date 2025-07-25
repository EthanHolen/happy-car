//
//  Persistence.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/15/21.
//

import CoreData


struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        
        
        for i in 0..<4 {
            let newVehicle = Vehicle(context: viewContext)
            newVehicle.name = "Vehicle \(i)"
            newVehicle.make = "Make \(i)"
            newVehicle.model = "Model \(i)"

        }
        
        
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Happy_Car")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context  = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    
        func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
            let context = container.viewContext
    
            context.delete(object)
    
            save(completion: completion)
    
        }
}
