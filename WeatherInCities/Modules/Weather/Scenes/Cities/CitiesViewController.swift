//
//  ViewController.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/14/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import UIKit
import RxSwift

class CitiesViewController: UIViewController {

    public var presenter: CitiesPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.viewDidLoad()
    }

    // MARK: - Setuping
    
    private func setup() {
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        navigationItem.title = "Weather"
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
}

