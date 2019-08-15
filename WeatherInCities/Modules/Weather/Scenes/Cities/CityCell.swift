//
//  CityCell.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    static let identifiere: String = "city_cell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureTitleLabel: UILabel!
}
