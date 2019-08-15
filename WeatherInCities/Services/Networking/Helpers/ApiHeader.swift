//
//  ApiHeader.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

public struct ApiHeaderKey {
    static let authRequired = "AuthorizationRequired"
    static let deviceInfo = "Device-Info"
    static let iosVersion = "IOS-Version"
    static let acceptLanguage = "Accept-Language"
    static let accept = "Accept"
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

public struct ApiHeaderValue {
    static let authRequired = "required"
    static let authNotRequired = "not_required"
    static let applicationJSON = "application/json"
    static let xWwwFormUrlencoded = "application/x-www-form-urlencoded"
}
