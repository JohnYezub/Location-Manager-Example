//
//  LocationManager.swift
//  Location Manager Singleton
//
//  Created by   admin on 20.07.2020.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
   
    var completeLocation: ((CLLocation?, Error?)->())?
    private var locationManager = CLLocationManager()
    ///we update user location once we get location
    ///use it for placemark
    private var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        ///once we get auth status - we request location or send nil to completion
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("authorized, requesting location...")
            //locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        default:
            print("no location access is allowed")
            completeLocation?(nil, nil)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let recentLocation = locations.last else {
            completeLocation?(nil, nil)
            return }
        print(locations)
        locationManager.stopUpdatingLocation()
        userLocation = recentLocation
        print("didUpdateLocations:")
        print(recentLocation as Any)
        completeLocation?(recentLocation, nil)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completeLocation?(nil, error)
        print("didFailWithError: \(error.localizedDescription)")
    }
}

// MARK: Get Placemark (location Address)
extension LocationManager {
    
    func getPlace(completion: @escaping (String) -> Void) {
        guard let location = userLocation else {
            print("placemark failed")
            return
        }
        var text = "no location"
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
               completion("no location")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion("no location")
                return
            }
            if let country = placemark.country, let area = placemark.administrativeArea {
                
                text = "\(country), \(area)"
            }
            completion(text)
        }
    } //end of getPlace
}
