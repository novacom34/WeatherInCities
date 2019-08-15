//
//  URL + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

extension URL {

    public var endpoint: String {
        let schemeAndHost = [self.scheme, self.host].compactMap { $0 }.joined(separator: "://")
        return [schemeAndHost, self.path].compactMap { $0 }.joined(separator: "")
    }
}
