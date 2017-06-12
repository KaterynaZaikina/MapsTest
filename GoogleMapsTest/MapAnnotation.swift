//
//  MapPoint.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/4/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class MapPoint: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var address: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, address: String?) {
        self.title = title
        self.coordinate = coordinate
        self.address = address
        super.init()
    }
    
}
