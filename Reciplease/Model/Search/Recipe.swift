//
//  Recipe.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// MARK: - Welcome!
struct Recipes: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
}
