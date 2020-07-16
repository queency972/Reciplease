//
//  UserIngredients.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class UserIngredient {

    // MARK: - Public Properties

    // Singleton property
    static var shared = UserIngredient()

    // Array with all of the ingredients
    var allIngredients = [String]()

    // Is the array empty ?
    var isEmpty: Bool {
        return allIngredients.isEmpty
    }

    // MARK: - Private methods

    /// Private init for singleton
    private init() {}

    // MARK: - Public Methods

    // Add a new ingredient to the array only if it doesn't contain a special character
    func addIngredient(_ ingredients: String ) -> Bool {
        guard !ingredients.specialCharacter else {
            return false
        }
        allIngredients.append(ingredients)
        return true
    }

    // Get all of the ingredients
    func getIngredients() -> String {
        var result = ""
        guard !allIngredients.isEmpty else {
            return result
        }

        for ingredient in allIngredients {
            result += "- \(ingredient)\n"
        }
        return result
    }

    // Reset all of the object (delete everything)
    func resetIngredients() {
        allIngredients = [String]()
    }
}
