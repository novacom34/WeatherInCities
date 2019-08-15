//
//  CitiesModel.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import RxSwift

class CitiesModel {
    
    // MARK: - Variables
    
    let entities: Variable<[CityEntity]> = Variable([])
    
    let status: Variable<DataSourceState> = Variable(.none)
    
    // MARK: - Private variables
    
    private let apiService: ApiService?
    
    private var dataTask: DataRequest?
    
    // MARK: - Lifecycle
    
    init(apiService: ApiService?) {
        self.apiService = apiService
    }
    
    // MARK: - Public methods
    
    public func loadCities() {
        status.value = .loading
        let context = CitiesContext()
        dataTask = apiService?
            .request(context)
            .validate()
            .logCurl()
            .responseDecodable(completionHandler: { [weak self] (response: DataResponse<CitiesResponseEntity>) in
                do {
                    let citiestResponseEntity = try response.result.get()
                    self?.status.value = .loaded
                    self?.entities.value = citiestResponseEntity.list
                } catch let error {
                    self?.status.value = .fail(error)
                }
            })
        dataTask?.resume()
    }
}

struct CitiesResponseEntity: Codable {
    
    let list: [CityEntity]

    private enum CodingKeys: String, CodingKey {
        case list
    }
}

struct CitiesContext: ApiRequest {
    
    // MARK: - Propetries
    
    var urlConvertible: URLConvertible = ApiEndpoint.weatherConditions
    var method: HTTPMethod? = .get
    var parameters: Encodable?
    var encoding: ParameterEncoding?
    var headers: HTTPHeaders? = []
    
    // MARK: - Parameters
    
    struct Parameters: Encodable {
        let bbox: String
        let appid: String = APIConstants.appid
    }
    
    // MARK: - Lifecycle
    
    init() {
        let citiesIds = "12,32,15,37,10" // For test
        self.parameters = CitiesContext.Parameters(bbox: citiesIds)
    }
}

