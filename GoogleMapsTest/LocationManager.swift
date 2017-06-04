//
//  LocationManager.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/4/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

//
//  LocationManager.swift
//
//
//  Created by kateryna.zaikina on 6/4/17.
//
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: class {
    
    func locationManager(_ manager: LocationManager, didGetCurrentLocation location: CLLocation)
    func locationManager(_ manager: LocationManager, didGetLocationWarningAlert alert: UIAlertController )
    func locationManager(_ manager: LocationManager, didFailWithError error: Error)
    func locationManagerDenied(_ manager: LocationManager)
    
}

extension LocationManagerDelegate {
    
    func getLocationWarningAlert(alert: UIAlertController) {}
    func locationRequestDidFailWithError(error: NSError) {}
    func locationRequestDenied() {}
    
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private let manager: CLLocationManager
    weak var delegate: LocationManagerDelegate?
    
    private override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }
    
    func updateCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            askForLocationPermission(status)
        }
    }
    
    //MARK: Location delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            askForLocationPermission(status)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        manager.stopUpdatingLocation()
        delegate?.locationManager(self, didGetCurrentLocation: currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(self, didFailWithError: error)
    }
    
    fileprivate func askForLocationPermission(_ status: CLAuthorizationStatus) {
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            let alert = UIAlertController(
                title: "Location Services Disabled",
                message: "Please enable Location Services in Settings",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let openAction = UIAlertAction(title: "Open settings", style: .default) { _ in
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            alert.addAction(openAction)
            
            delegate?.locationManager(self, didGetLocationWarningAlert: alert)
        }
    }
    
}
