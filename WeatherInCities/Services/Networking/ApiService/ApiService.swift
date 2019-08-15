//
//  ApiService.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import Alamofire

public typealias Parameters = Alamofire.Parameters
public typealias URLConvertible = Alamofire.URLConvertible
public typealias DataRequest = Alamofire.DataRequest
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias URLEncoding = Alamofire.URLEncoding
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias DataResponse = Alamofire.DataResponse
public typealias URLRequestConvertible = Alamofire.URLRequestConvertible

public class ApiService {

    // MARK: - Properties

    public let configuration: URLSessionConfiguration
    public let session: Session
    public let delegate: Alamofire.SessionDelegate

    // MARK: - Init

    init() {
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        session = Alamofire.Session(configuration: configuration, interceptor: nil)
        delegate = session.delegate
    }

    // MARK: - Public methods

    public func request(_ context: ApiRequest) -> DataRequest {
        return session.request(context)
    }
}
