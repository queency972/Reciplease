//
//  UrlEncoder.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// MARK: - Protocol Enconder

// Encoder URL.
protocol UrlEncoder {
    func encode(baseUrl: URL, parameters: [(String, Any)]?) -> URL
}

// MARK: - Extention Encoder

extension UrlEncoder {
    func encode(baseUrl: URL, parameters: [(String, Any)]?) -> URL {
        // check resolvingAgainstBaseURL
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else {return baseUrl}

        urlComponents.queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else {return baseUrl}
        return url
    }
}
