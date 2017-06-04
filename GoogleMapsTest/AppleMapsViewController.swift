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
        let identifier = "pin"
        var view: MKPinAnnotationView
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.canShowCallout = true
        let detailCalloutAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        let label = UILabel()
        label.numberOfLines = 0
        label.text = annotation.subtitle
        detailCalloutAccessoryView.addSubview(label)
        view.detailCalloutAccessoryView = detailCalloutAccessoryView
        
        
        return view
    }
    
}

extension AppleMapsViewController: LocationUpdatable {
    
    func locationDidChange(_ location: CLLocation) {
    
    }
    
    func centerAroundLocation(_ location: CLLocation) {
        let region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.03, 0.03))
        mapView.setRegion(region, animated: false)
    }
    
}
