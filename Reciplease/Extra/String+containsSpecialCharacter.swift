//
//  String+containsSpecialCharacter.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// MARK: - Extension String
extension String {
    // Calculated the property to know if there is any special character in the string
    var specialCharacter: Bool {
        let regex = ".*[^A-Za-z ].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
}
