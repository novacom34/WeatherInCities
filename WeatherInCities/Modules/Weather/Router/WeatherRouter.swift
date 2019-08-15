//
//  WeatherRouter.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherRouterDelegate: class {
    func perform(_ action: WeatherRouter.Action)
}

class WeatherRouter {
    
    // MARK: - Enum
    
    enum Action {
        case cities
        case citysDetails
        case error(error: Error)
    }
    
    // MARK: - Properties
    
    private weak var appRouter: AppRouterDelegate?
    private weak var naviagtionController: UINavigationController?
    
    // MARK: - Lifecycle
    
    init(appRouter: AppRouterDelegate) {
        self.appRouter = appRouter
    }
    
    // MARK: - Public methods
    
    private func showCities() {
        let storyboard = UIStoryboard(name: Identifiers.Storyboards.Weather.rawValue, bundle: nil)
        naviagtionController = storyboard.instantiateInitialViewController() as? UINavigationController
        naviagtionController?.navigationBar.prefersLargeTitles = true
        naviagtionController?.navigationItem.largeTitleDisplayMode = .automatic
        
        let citiesController = storyboard.instantiateViewController(withIdentifier: Identifiers.Controller.cities.rawValue) as? CitiesViewController
        let citiesModel = CitiesModel(apiService: appRouter?.application.apiService)
        let citiesPresenter = CitiesPresenter(view: citiesController, router: self, model: citiesModel)
        citiesController?.presenter = citiesPresenter

        if let naviagtionController = naviagtionController, let citiesController = citiesController {
            naviagtionController.pushViewController(citiesController, animated: false)
            appRouter?.perform(.setRootViewController(naviagtionController))
        }
    }
}

// MARK: - LoginRouterDelegate

extension WeatherRouter: WeatherRouterDelegate {
    
    func perform(_ action: WeatherRouter.Action) {
        switch action {
        case .cities:
            showCities()
        case .citysDetails:
            break
        case .error(let error):
            appRouter?.perform(.error(error: error))
        }
    }
}
