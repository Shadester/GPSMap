//
//  MapViewController.swift
//  GPSMap
//
//  Created by Erik Lindberg on 2018-02-03.
//  Copyright © 2018 Erik Lindberg. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    let mapView: MKMapView = {
        let m = MKMapView()
        m.translatesAutoresizingMaskIntoConstraints = false
        m.mapType = MKMapType.standard
        m.isZoomEnabled = true
        m.isScrollEnabled = true
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mapView)
        
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        let guide = view.safeAreaLayoutGuide
        mapView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0).isActive = true
        guide.bottomAnchor.constraintEqualToSystemSpacingBelow(mapView.bottomAnchor, multiplier: 1.0).isActive = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // Check for Location Services
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
            mapView.setRegion(viewRegion, animated: false)
            
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
            
            let location = Location(timeStamp: Date(), latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let networkManager = NetworkManager()
            networkManager.submitLocation(location: location, completion: nil)
        }
    }
}
