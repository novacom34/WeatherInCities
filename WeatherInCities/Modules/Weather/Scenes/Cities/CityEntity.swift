//
//  CityEntity.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

struct CityEntity: Codable {
    
    let name: String
    let main: Main
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
    }
}

struct Main: Codable {
    let temperature: Float
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
