//
//  Typealias.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//

import Foundation

public typealias Completion = () -> ()
public typealias ErrorCompletion = (Error?) -> ()
public typealias ComposerCompletion = (AlertComposer) -> ()
public typealias ActionSheetCompletion = (Int, String) -> ()
