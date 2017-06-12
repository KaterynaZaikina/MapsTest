//
//  DataProvider.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/4/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlaces

class DataProvider {
    
    private(set) var mapPoints: [MapPoint] = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let filePath = Bundle.main.path(forResource: "data", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(string: "file://\(filePath!)")!, options: .alwaysMapped)
            parseData(data)
        } catch {
            print(error)
        }
    }
    
    private func parseData(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
            guard let places = json?["results"] as? [[String: Any]] else { return }
            
            for place in places {
                let geo = place["geometry"] as! [String: Any]
                let name = place["name"] as! String
                let vicinity = place["vicinity"] as! String
                let location = geo["location"] as! [String: Any]
                
                let coordinate = CLLocationCoordinate2D(latitude: location["lat"] as! Double, longitude: location["lng"] as! Double)
                
                let mapPoint = MapPoint(title: name, coordinate: coordinate, address: vicinity)
                mapPoints.append(mapPoint)
            }
        }
    }

}
