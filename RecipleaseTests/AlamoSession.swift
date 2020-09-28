//
//  AlamoSession.swift
//  RecipleaseTests
//
//  Created by Steve Bernard on 21/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import Alamofire

// Call Network with Alamofire
protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

// MARK: - Class RecipeSession

class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (data) in
            callBack(data)
        }
    }
}
