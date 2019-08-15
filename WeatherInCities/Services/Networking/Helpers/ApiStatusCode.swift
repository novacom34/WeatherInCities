//
//  ApiStatusCode.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

public struct ApiStatusCode {
    static let unauthorized = 401
    static let fileNotFound = 404
    static let notValidVersion = 410
    static let noInternetConnection = 808
    static let unknownError = 999

    static let valid = 200..<300
}

