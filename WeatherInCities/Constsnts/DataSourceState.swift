//
//  Common.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

enum DataSourceState {
    case none
    case loading
    case loaded
    case fail(Error)
}
