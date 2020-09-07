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
    // private let favorite = RecipeDetailViewController()
    
    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        guard let ingredient = try? managedObjectContext.fetch(request) else { return [] }
        return ingredient
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Functions

    // Check if favorite already exist in CoreData
    func isRecipeRegistered(title: String) -> Bool {
         let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        // Apply filter in database
        request.predicate = NSPredicate(format: "title = %@", title)
        // Stock and execute request
        guard let recipeEntities = try? managedObjectContext.fetch(request) else {return false}
        if recipeEntities.isEmpty { return false }
        return true
    }

    // Manage Ingredient Entity
    func createRecipe(title: String, ingredients: [String], time: String, url: String, yield: String, image: Data?) {
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.time = (time)
        recipe.yield = (yield)
        recipe.url = url
        recipe.image = image
        coreDataStack.saveContext()
        print("CoreDataManager")
        print(ingredients)
    }
    
    func deleteRecipe(title: String) {
    
    }
}
