//
//  ApiLoadingState.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

// MARK: - ApiRequestDelegate

public protocol ApiRequestDelegate: class {

    func didChangeState(_ newState: ApiLoadingState)
}

// MARK: - ApiLoadingState

public enum ApiLoadingState {

    case idle
    case loading
    case loaded
    case contentUnavailable
    case refreshing
    case error(Error)

    var isLoading: Bool {
        return [ApiLoadingState.loading, .refreshing].contains(self)
    }

    var isNotLoading: Bool {
        return !isLoading
    }
}

// MARK: - Equatable

extension ApiLoadingState: Equatable {

    public static func == (lhs: ApiLoadingState, rhs: ApiLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.loaded, .loaded), (.contentUnavailable, .contentUnavailable), (.refreshing, .refreshing):
            return true
        case (.error(let lhsError), .error(error: let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
