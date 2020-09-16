//
//  RecipeService.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

final class RecipeService: UrlEncoder {

    // MARK: - Enum.

    enum NetworkError: Error {
        case noData
        case noResponse
        case unDecodable
    }

    // MARK: - Properties
    private let session: AlamoSession

    init(session: AlamoSession = RecipeSession()) {
        self.session = session
    }

    // MARK: - Method

    func getRecipe(ingredientsFormatted: String, callback: @escaping (Result<Recipes, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: "https://api.edamam.com/search") else { return }
        let url = encode(baseUrl: baseUrl, parameters: [("q",ingredientsFormatted),("app_id","14e1ea8c"),("app_key","3908c9aa702cae84cf32d6edad253d80")])
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(Recipes.self, from: data) else {
                callback(.failure(.unDecodable))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
