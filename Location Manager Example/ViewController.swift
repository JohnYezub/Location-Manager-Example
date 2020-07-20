//
//  ViewController.swift
//  Location Manager Singleton
//
//  Created by   admin on 20.07.2020.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.completeLocation = { location, error in
            if location != nil {
                print("VC")
                print(location!)
                self.locationName()
            } else {
                print("failed to get location")
            }                        
        }
    }
    
    func locationName() {
        locationManager.getPlace() { [weak self] text in
            print(text)
        }
    }


}

