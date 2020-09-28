//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    // Simulate error. Get an implementation protocol Error.
    class NetworkError: Error {}
    static let networkError = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Data", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}
