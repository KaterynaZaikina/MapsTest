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
import MapKit

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
        centerAroundLocation(CLLocation(latitude: -33.865143, longitude: 151.209900))
    }
    
}


extension GoogleMapsViewController: GMSMapViewDelegate {
    
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
    
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoView = InfoView.loadFromNib()
        infoView.text = marker.title
        
        marker.tracksInfoWindowChanges = true
        infoView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            infoView.alpha = 1
        }, completion: { _ in
             marker.tracksInfoWindowChanges = false
        })
        
        return infoView
    }

}

extension GoogleMapsViewController: LocationUpdatable {
    
    func locationDidChange(_ location: CLLocation) {
        
    }
    
    func centerAroundLocation(_ location: CLLocation) {
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 14)
        mapView.camera = position
    }
    
    func addAnnotations(_ annotations: [MKAnnotation]) {
        mapView.clear()
        annotations.forEach {
            let marker = GMSMarker(position: $0.coordinate)
            let imageView = UIImageView(image: UIImage(named: "iconMap"))
            imageView.frame.size = CGSize(width: 40, height: 40)
            marker.iconView = imageView
            marker.title = $0.title!
            marker.map = mapView
            marker.appearAnimation = .pop
        }
    }
    
}
