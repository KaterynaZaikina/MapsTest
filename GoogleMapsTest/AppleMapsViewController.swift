//
//  AppleMapsViewController.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 5/26/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import MapKit

class AppleMapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
    }
    
    private func setupMapView() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        centerAroundLocation(CLLocation(latitude: -33.865143, longitude: 151.209900))
    }
    
    fileprivate func setPin(at location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "Current location"
        addAddress(from: location, to: annotation)
        
        mapView.addAnnotation(annotation)
    }
    
    private func addAddress(from location: CLLocation, to annotation: MKPointAnnotation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                annotation.subtitle = placemark.addressDictionary?.description
            }
        }
    }

}

extension AppleMapsViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MapPoint else { return nil }
        
        let identifier = "pin"
        var annotationView: MapAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MapAnnotationView {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MapAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
                
        return annotationView
    }
    
}

extension AppleMapsViewController: LocationUpdatable {
    
    func locationDidChange(_ location: CLLocation) {}
    
    func centerAroundLocation(_ location: CLLocation) {
        let region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.03, 0.03))
        mapView.setRegion(region, animated: false)
    }
    
    func addAnnotations(_ annotations: [MKAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
}
