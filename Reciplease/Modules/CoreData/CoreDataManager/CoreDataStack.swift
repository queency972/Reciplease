//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Steve Bernard on 01/07/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack {

    // MARK: - Properties

       private let modelName: String

       // MARK: - Initializer

       public init(modelName: String) {
           self.modelName = modelName
       }

    // MARK: - Core Data stack

    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName )
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
