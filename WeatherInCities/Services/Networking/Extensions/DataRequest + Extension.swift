//
//  DataRequest + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    var validatedByCodeAndContentType: DataRequest {
        return self
            .validate(statusCode: ApiStatusCode.valid)
            .validate(contentType: [ApiHeaderValue.applicationJSON])
    }
    
    public func logCurl() -> DataRequest {
        convertible.urlRequest?.logCurl()
        return self
    }
}
