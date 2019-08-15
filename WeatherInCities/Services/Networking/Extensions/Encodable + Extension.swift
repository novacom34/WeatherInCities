//
//  Encodable + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

extension Encodable {

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    public func convertToStringDataDictionary() throws -> [String : Data] {
        guard let paramsDictionary = self.dictionary,
            !paramsDictionary.isEmpty else {
                return [String : Data]()
        }
        var uploadParamsData = [String : Data]()
        for (key, value) in paramsDictionary {
            let data = try JSONSerialization.data(withJSONObject: value)
            uploadParamsData[key] = data
        }
        return uploadParamsData
    }
}
