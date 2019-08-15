//
//  ExapmpleApp.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import UIKit

class Application {

    /// Application router is used to navigate user troought application.
    lazy var applicationRouter: ApplicationRouter = ApplicationRouter(application: self)
    
    /// Api service is used to make requests to server.
    private (set) lazy var apiService: ApiService = {
        let apiService = ApiService()
        return apiService
    }()

    // MARK: - Lifecycle

    init() {
        applicationRouter.perform(.start)
    }

    // MARK: -  Private methods
    
}
