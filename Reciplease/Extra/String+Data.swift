//
//  String+Data.swift
//  Reciplease
//
//  Created by Steve Bernard on 10/08/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// MARK: - Extension String
extension String {
    // Convert string to data
    var data: Data? {
        guard let url = URL(string: self) else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}

extension Data {
    var utf8String: String? {
        return string(as: .utf8)
    }
    func string(as encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
}
