//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Steve Bernard on 27/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (data) in
            callBack(data)
        }
    }
}
