//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

@testable import Reciplease
import XCTest

class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: FakeCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createRecipe(title: "toto", ingredients: ["toto"], time: "3", url: "//https:apple.com", yield: "3", image: FakeResponseData.correctData)
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "toto")
    }

    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createRecipe(title: "toto", ingredients: ["toto"], time: "3", url: "//https:apple.com", yield: "3", image: FakeResponseData.correctData)
        coreDataManager.deleteRecipe(title: "toto")
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
    }

    func testAddRecipe_WhenAnEntityIsEmpty_ThenShouldHaveRecipeInCoreData() {
        if coreDataManager.isRecipeRegistered(title: "egg") {
            XCTAssertTrue(!coreDataManager.recipes.isEmpty)
            XCTAssertTrue(coreDataManager.recipes.count == 1)
            XCTAssertTrue(coreDataManager.recipes[0].title == "egg")
        }
    }

    func testAddRecipe_WhenRecipeIsAlreadyPresent_ThenShouldHaveNotAddRecipeInCoreData() {
        coreDataManager.createRecipe(title: "egg", ingredients: ["egg"], time: "3", url: "//https:apple.com", yield: "3", image: FakeResponseData.correctData)

        if !coreDataManager.isRecipeRegistered(title: "egg") {
            XCTAssertTrue(coreDataManager.recipes[0].title == "egg")
            XCTAssertTrue(!coreDataManager.recipes.isEmpty)
            XCTAssertTrue(coreDataManager.recipes.count == 1)
            XCTAssertTrue(coreDataManager.recipes[0].title == "egg")
            XCTAssertTrue(!coreDataManager.isRecipeRegistered(title: "egg"))
        }
    }
}
