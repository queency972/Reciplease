//
//  URLRecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// Double class reponsible of the call network
class URLRecipeSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLRecipeSessionDataTaskFake(data: data, urlResponse: response, responseError: error)
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

// Double class reponsible of the call network. (func resume(), func cancel())
class URLRecipeSessionDataTaskFake: URLSessionDataTask {
    // Block back getRates()
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    init(data: Data?, urlResponse: URLResponse?, responseError: Error? ) {
    }

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
