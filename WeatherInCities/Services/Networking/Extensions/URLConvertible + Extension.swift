//
//  URLConvertible + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

extension URLConvertible {

    var endpoint: String {
        guard let url = try? self.asURL() else {
            fatalError("could't handle endpoint")
        }
        return url.endpoint
    }
}
