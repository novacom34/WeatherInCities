//
//  TimeInterval + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    struct alert {
        static let short = TimeInterval(0.75)
        static let medium = TimeInterval(1.5)
        static let long = TimeInterval(2.5)
    }
    
    struct animation {
        static let t0_15 = TimeInterval(0.15)
        static let short = TimeInterval(0.25)
        static let medium = TimeInterval(0.45)
        static let long = TimeInterval(0.9)
        static let extraLong = TimeInterval(1.35)
    }
}
