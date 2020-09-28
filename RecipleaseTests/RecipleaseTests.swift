//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 26/05/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import XCTest
@testable import Reciplease
@testable import Alamofire

class RecipleaseTests: XCTestCase {

    func testGetRecipeShouldPostFailedCallbackIfError() {
        // Given
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        // When
        let userIngredient = UserIngredient()
        requestService.getRecipe(ingredientsFormatted: userIngredient.ingredientsString)  { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetTranslateShouldPostFailedCallbackIfError failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
