//
//  orders.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/2/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import CoreLocation

class orders: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let locValue:CLLocationCoordinate2D = manager.location!.coordinate
           }
    override func viewDidLoad() {
        self.view.addLabel(text: "orders")
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        print(locationManager.location!.coordinate)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
