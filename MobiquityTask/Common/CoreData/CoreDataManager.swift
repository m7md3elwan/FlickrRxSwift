//
//  CoreDataManager.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK:- Singleton
    static let shared: CoreDataManager = CoreDataManager()
    
    // MARK:- Properties
    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MobiquityTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let persistentContainerLoadError = error {
                fatalError("Unresolved error \(persistentContainerLoadError), \(persistentContainerLoadError.userInfo)")
            }
        })
        return container
    }()
    
    // MARK:- Methods
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
