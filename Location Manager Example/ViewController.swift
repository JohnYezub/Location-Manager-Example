//
//  ViewController.swift
//  Location Manager Singleton
//
//  Created by   admin on 20.07.2020.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var locationManager = LocationManager()
    
    private var locationLabel: UILabel!
    
    private var locationPlace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        locationManager.completeLocation = { [weak self] location, error in
            if location != nil {
                print("ViewController gets location:")
                print(location!)
                self?.locationLabel.text = "\(location!.coordinate.latitude) \(location!.coordinate.longitude)"
                self?.locationName()
            }
            if location == nil || error != nil {
                self?.locationLabel.text = "Failed to get location"
            }
        }
    }
    
    //MARK: UI
    private func setupUI(){
        locationLabel = UILabel()
        locationLabel.text = ""
        locationLabel.textColor = .darkGray
        locationLabel.font = UIFont(name: "Helvetica", size: 18)
        locationLabel.textAlignment = .center
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        locationPlace = UILabel()
        locationPlace.text = ""
        locationPlace.textColor = .darkGray
        locationPlace.font = UIFont(name: "Helvetica", size: 18)
        locationPlace.textAlignment = .center
        view.addSubview(locationPlace)
        locationPlace.translatesAutoresizingMaskIntoConstraints = false
        locationPlace.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        locationPlace.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        locationPlace.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        
    }
    
    //MARK: retrieve placemark on completion
    private func locationName() {
        locationManager.getPlace() { [weak self] text in
            self?.locationPlace.text = text
            print(text)
        }
    }
    
    
}

