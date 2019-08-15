//
//  URLRequest + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

public extension URLRequest {

    func logCurl() {
        print(curlString)
    }

    var curlString: String {

        #if !DEBUG

        return ""

        #else

        guard let url = url else {
            return ""
        }

        var baseCommand = "curl"

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "HEAD" {
            command.append("-X \(method)")
        }

        command.append("'" + url.absoluteString + "'")

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
        
        #endif
    }
}
