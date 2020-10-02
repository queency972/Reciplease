//
//  String+Data.swift
//  Reciplease
//
//  Created by Steve Bernard on 10/08/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension String

// Convert string to data
extension String {
    var data: Data? {
        guard let url = URL(string: self) else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}

// MARK: - Extension Data

// Convert Data to UIImage
extension Data {
    var uiImage: UIImage? { UIImage(data: self) }
}

