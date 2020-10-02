//
//  UserIngredientTest.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 02/10/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//
import XCTest
@testable import Reciplease


class UserIngredientTests: XCTestCase {

    func testArrayIfVarIsEmptyShouldSuccessIfNoIngredientInArray() {
        let ingredient = UserIngredient()
        XCTAssertTrue(ingredient.isEmpty)
    }

    func testArrayIfContentIngredientShouldSuccessIfIngredientInArray() {
        let ingredient = UserIngredient()
        ingredient.addIngredient("egg")
        XCTAssertTrue(!ingredient.isEmpty)
    }

    func testContentArrayShouldSuccessIfNoIngredientInArray() {
        let ingredient = UserIngredient()
        ingredient.addIngredient("egg")
        ingredient.resetIngredients()
        XCTAssertTrue(ingredient.allIngredients.isEmpty)
    }

    func testDeleteIngredientArrayShouldSuccessIfOneIngredientHasbeenDeleted() {
        let ingredient = UserIngredient()
        ingredient.addIngredient("egg")
        ingredient.addIngredient("lemon")
        ingredient.removeIngredient(at: 1)
        XCTAssertTrue(!ingredient.allIngredients.isEmpty)
        XCTAssertTrue(ingredient.allIngredients.count == 1)
    }
}
