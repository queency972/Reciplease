//
//  FakeitunesSession.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

@testable import Alamofire
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

// AlamoSession (Protocol)
 class FakeRecipeSession: AlamoSession {

    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods

    // Function "request" du protocol
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data

        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
        callBack(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
