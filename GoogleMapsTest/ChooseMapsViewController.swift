//
//  ChooseMapsViewController.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 5/26/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

private enum MapType: Int {

    case google = 0, apple
    
    static var numberOfTypes = 2
    
    var title: String {
        switch self {
        case .google:
            return "Google Maps"
        case .apple:
            return "Apple Maps"
        }
    }

}

class ChooseMapsViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var locationManager = LocationManager.shared
    
    private var currentMapType: MapType! {
        didSet {
            changeMapType()
        }
    }
    
    fileprivate var currentController: UIViewController! {
        switch currentMapType! {
        case .google:
            return googleMapsController
        case .apple:
            return appleMapsController
        }
    }
    
    private var googleMapsController: GoogleMapsViewController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: "GoogleMapsViewController") as? GoogleMapsViewController
    }()
    
    private var appleMapsController: AppleMapsViewController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: "AppleMapsViewController") as? AppleMapsViewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSegmentedControl()
        locationManager.delegate = self
    }
    
    private func setupSegmentedControl() {
        for index in 0..<segmentedControl.numberOfSegments {
            segmentedControl.setTitle(MapType(rawValue: index)!.title, forSegmentAt: index)
        }
        currentMapType = MapType(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    private func addViewController(_ controller: UIViewController) {
        guard childViewControllers.filter({ $0 == controller }).first == nil else { return }
        
        addChildViewController(controller)

        containerView.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        controller.didMove(toParentViewController: self)
    }
    
    private func removeViewController(_ controller: UIViewController) {
        guard childViewControllers.filter({ $0 == controller }).first != nil else { return }
        
        controller.willMove(toParentViewController: nil)
        controller.view.snp.removeConstraints()
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    private func changeMapType() {
        switch currentMapType! {
        case .google:
            removeViewController(appleMapsController)
            addViewController(googleMapsController)
        case .apple:
            removeViewController(googleMapsController)
            addViewController(appleMapsController)
        }
    }
    
    @IBAction private func changeMaps(_ sender: UISegmentedControl) {
        currentMapType = MapType(rawValue: sender.selectedSegmentIndex)!
        locationManager.updateCurrentLocation()
    }
    
}

extension ChooseMapsViewController: LocationManagerDelegate {
    
    func locationManager(_ manager: LocationManager, didGetCurrentLocation location: CLLocation) {
        if let controller = currentController as? LocationUpdatable {
            controller.centerAroundLocation(location)
        }
    }
    
    func locationManager(_ manager: LocationManager, didGetLocationWarningAlert alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: LocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDenied(_ manager: LocationManager) {}
    
}
