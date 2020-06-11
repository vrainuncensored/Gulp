//
//  orders.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/2/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class orders: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let locValue:CLLocationCoordinate2D = manager.location!.coordinate
           }
    var longitude = 0.0
    var latitude = 0.0
    
    override func viewDidLoad() {
        self.view.addLabel(text: "orders")
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        self.longitude = locationManager.location!.coordinate.longitude
        self.latitude = locationManager.location!.coordinate.latitude
        fbCall(latitude: latitude, longitude: longitude)
    
        }
        
    func fbCall (latitude: Double, longitude:Double) {
           let user = Auth.auth().currentUser
           if let user = user {
               let uid = user.uid
               if Auth.auth().currentUser != nil {
                   let docRef = Firestore.firestore().collection("merchant").document(uid)
                docRef.updateData([
                    "locationCoordinates": GeoPoint(latitude: latitude, longitude: longitude)
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
        
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
}
}
