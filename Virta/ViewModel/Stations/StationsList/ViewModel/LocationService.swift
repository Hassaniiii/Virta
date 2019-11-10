//
//  LocationService.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import CoreLocation
import Combine

protocol LocationService {
    var location: PassthroughSubject<CLLocation?, Never> { get }
    var locationValue: CLLocation? { get }
}

final class LocationServiceImpl: NSObject, LocationService {
    
    // MARK: - LocationService
    
    var locationValue: CLLocation? {
        didSet {
            self.location.send(locationValue)
        }
    }
    var location = PassthroughSubject<CLLocation?, Never>()
    
    // MARK: - LocationServiceImpl
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension LocationServiceImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let oldLocation = locationValue else {
            self.locationValue = manager.location
            return
        }
        
        /// only update significant location changes
        if let newLocation = manager.location, oldLocation.distance(from: newLocation) / 1000 >= 1 {
            self.locationValue = manager.location
        }
    }
}
