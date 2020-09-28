//
//  FakeCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Reciplease
import Foundation
import CoreData

final class FakeCoreDataStack: CoreDataStack {

    // MARK: - Initializer

    convenience init() {
        self.init(modelName: "Reciplease")
    }

    override init(modelName: String) {
        // utilisation func init de la classe mere
        super.init(modelName: modelName)
        // creation type de store
        let persistentStoreDescription = NSPersistentStoreDescription()
        //
        persistentStoreDescription.type = NSInMemoryStoreType
        // creation d'un nouveau container
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        // loading.
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
