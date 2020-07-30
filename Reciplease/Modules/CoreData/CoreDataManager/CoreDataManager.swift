//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Steve Bernard on 01/07/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var allIngredients: [AllIngredient] {
        let request: NSFetchRequest<AllIngredient> = AllIngredient.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "ingredient", ascending: true)]
        guard let ingredient = try? managedObjectContext.fetch(request) else { return [] }
        return ingredient
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Ingredient Entity

    func favorisRecipes(name: String) {
        let ingredient = AllIngredient(context: managedObjectContext)
        ingredient.ingredient = name
        coreDataStack.saveContext()
    }
}
