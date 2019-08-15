//
//  ApiRequest.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

public protocol ApiRequest: URLRequestConvertible {

    var urlConvertible: URLConvertible { get }
    var method: HTTPMethod? { get }
    var parameters: Encodable? { get }
    var encoding: ParameterEncoding? { get }
    var headers: HTTPHeaders? { get }

    func asURLRequest() throws -> URLRequest
}

public extension ApiRequest {

    // MARK: - Properties

    var defaultHTTPMethod: HTTPMethod {
        return .get
    }

    var defaultEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var endpoint: String {
        return urlConvertible.endpoint
    }

    private var _encoding: ParameterEncoding {
        return self.encoding ?? defaultEncoding
    }

    private var _method: HTTPMethod {
        return self.method ?? defaultHTTPMethod
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try urlConvertible.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = _method.rawValue
        urlRequest = try _encoding.encode(urlRequest, with: parameters?.dictionary ?? [:])
        urlRequest.allHTTPHeaderFields = headers?.dictionary
        return urlRequest
    }
}
