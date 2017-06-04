//
//  LocationUpdatable.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/4/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationUpdatable {
    
    func locationDidChange(_ location: CLLocation)
    func centerAroundLocation(_ location: CLLocation)
    
}
