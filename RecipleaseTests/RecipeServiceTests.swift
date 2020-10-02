//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 26/05/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeServiceTests: XCTestCase {

    // Test NoData
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        // When
        let userIngredient = UserIngredient()
        requestService.getRecipe(ingredientsFormatted: userIngredient.ingredientsString)  { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRecipeShouldPostFailedCallbackIfNoData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }


    // Test IncorrectResponse
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let userIngredient = UserIngredient()

        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        requestService.getRecipe(ingredientsFormatted: userIngredient.ingredientsString)  { result in

            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRecipeShouldPostFailedCallbackIfIncorrectResponse failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let userIngredient = UserIngredient()

        // When
        let expectation = XCTestExpectation(description: "Waiting...")

        requestService.getRecipe(ingredientsFormatted: userIngredient.ingredientsString)  { result in
            // Then
            guard case .success  (let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            expectation.fulfill()
        }
    }

    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndInCorrectData() {
        // Given
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = RecipeService(session: session)
        let userIngredient = UserIngredient()

        // When
        let expectation = XCTestExpectation(description: "Waiting...")

        requestService.getRecipe(ingredientsFormatted: userIngredient.ingredientsString)  { result in
            // Then
            guard case .failure  (let failure) = result else {
                return
            }
            XCTAssertNotNil(failure)
            expectation.fulfill()
        }
    }
}
