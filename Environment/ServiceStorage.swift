//
//  ServiceStorage.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import CoreData

public final class ServiceStorage {
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Environment")
        container.loadPersistentStores { _, error in
            if let error {
                preconditionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
