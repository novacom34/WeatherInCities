//
//  ApplicationRouter.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import UIKit

protocol AppRouterDelegate: class {

    var application: Application! { get }
    
    func perform(_ routeAction: ApplicationRouter.Action)
}

class ApplicationRouter  {
    
    // MARK: - Enum
    
    enum Action {
        case start
        case setRootViewController(UIViewController)
        case error(error: Error)
        case errorComposer(composer: AlertComposer)
    }
    
    // MARK: - Private
    
    public weak var application: Application!
    
    private let window: UIWindow
    
    private let alertService = AlertService()
    
    private lazy var weatherRouter = WeatherRouter(appRouter: self)
    
    // MARK: - Lifecycle
    
    init(application: Application) {
        self.application = application
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Private methods
    
    private func setRootViewController(_ controller: UIViewController) {
        let options = UIWindow.TransitionOptions(direction: .fade, style: .easeIn)
        window.setRootViewController(controller, options: options)
    }
}

// MARK: - AppRouterDelegate

extension ApplicationRouter: AppRouterDelegate {
    
    func perform(_ routeAction: Action) {
        switch routeAction {
        case .start:
            weatherRouter.perform(.cities)
        case .setRootViewController(let rootViewController):
            setRootViewController(rootViewController)
        case .error(let error):
            alertService.showAlert(error: error)
        default:
            return
        }
    }
}
