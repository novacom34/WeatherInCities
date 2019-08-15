//
//  CitiesPresenter.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CitiesPresenter {
    
    // MARK: - Properties
    
    private weak var view: CitiesViewController?
    private weak var router: WeatherRouterDelegate?
    private let model: CitiesModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(view: CitiesViewController?, router: WeatherRouterDelegate?, model: CitiesModel) {
        self.view = view
        self.router = router
        self.model = model
        model.loadCities()
    }
    
    // MARK: - Actions
    
    func viewDidLoad() {
        bind()
    }
    
    // MARK: - Binding
    
    private func bind() {
        bindStatus()
        bindTable()
    }
    
    private func bindTable() {
        guard let tableView = view?.tableView else {
            return
        }
        
        model.entities
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CityCell.identifiere, cellType: CityCell.self))
            { _, element, cell in
                cell.cityNameLabel.text = "📍" + element.name
                cell.temperatureTitleLabel.text = String(format: "%.0f", element.main.temperature) + "℃"
            }
            .disposed(by: disposeBag)
    }
    
    private func bindStatus() {
        model.status.asObservable().subscribe(onNext: { [weak self] (state) in
            switch state {
            case .none:
                break
            case .loading:
                self?.view?.activityIndicator.startAnimating()
            case .loaded:
                self?.view?.activityIndicator.stopAnimating()
            case .fail(let error):
                self?.view?.activityIndicator.stopAnimating()
                self?.router?.perform(.error(error: error))
            }
        }).disposed(by: disposeBag)
    }
}

