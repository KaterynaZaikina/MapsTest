//
//  GoogleMapsViewController.swift
//  GoogleMaps
//
//  Created by kateryna.zaikina on 5/25/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SnapKit

class GoogleMapsViewController: UIViewController {
    
    fileprivate var mapView: GMSMapView!
    
    var marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
    }
    
    private func setupMapView() {
        mapView = GMSMapView(frame: view.frame)
        
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
}


extension GoogleMapsViewController: GMSMapViewDelegate {
    
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
    
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        view.layer.cornerRadius = 10
        view.backgroundColor = .green
        
        return view
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        view.layer.cornerRadius = 10
        view.backgroundColor = .green
        
        return view
    }

}

extension GoogleMapsViewController: LocationUpdatable {
    
    func locationDidChange(_ location: CLLocation) {
        
    }
    
    func centerAroundLocation(_ location: CLLocation) {
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 14)
        mapView.camera = position
    }
    
}
