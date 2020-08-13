//
//  LocationPageViewController.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 8/12/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import FirebaseFunctions
import CoreLocation
import Firebase

class LocationPageViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    }
    var longitude = 0.0
    var latitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
          
        // Do any additional setup after loading the view.
    }
    
    func updateUser() {
        self.longitude = locationManager.location!.coordinate.longitude
        self.latitude = locationManager.location!.coordinate.latitude
        let data : [String : Any] = [
            "location" : GeoPoint(latitude: latitude, longitude: longitude),
            
        ]
        
        Functions.functions().httpsCallable("updateLocation").call(data) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", msg: "Unable to change location.")
                return
            }
        }
    

}
    
    
}
