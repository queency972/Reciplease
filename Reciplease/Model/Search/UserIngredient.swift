//
//  UserIngredients.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

final class UserIngredient {
    
    // MARK: - Public Propertie
    
    // Array with all of the ingredients
    var allIngredients = [String]()
    
    var ingredientsString: String {
        return allIngredients.joined(separator: ",")
    }
    
    // Is the array empty ?
    var isEmpty: Bool {
        return allIngredients.isEmpty
    }
    
    // MARK: - Methods
    
    // Add a new ingredient to the array
    func addIngredient(_ ingredients: String)   {
        allIngredients.append(ingredients)
    }
    
    // Reset all of the object (delete everything)
    func resetIngredients() {
        allIngredients = [String]()
    }
    // Remove ingredient
    func removeIngredient(at index: Int) {
         allIngredients.remove(at: index)
     }
}
