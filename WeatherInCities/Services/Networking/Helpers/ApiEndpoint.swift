//
//  ApiEndpoint.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

public struct APIConstants {
    static let baseUrl = "http://api.openweathermap.org/data/2.5/"
    static let appid = "a1d1dc41d71e2b1c1d329e64770bf088"
}

public enum ApiEndpoint: String {
    case weatherConditions = "box/city"
}

// MARK: - URLConvertible

extension ApiEndpoint: URLConvertible {

    public func asURL() throws -> URL {
        let path = APIConstants.baseUrl + self.rawValue
        if let url = URL(string: path) {
            return url
        }
        throw AFError.parameterEncodingFailed(reason: .missingURL)
    }
}
