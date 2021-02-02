//
//  paymentHistory.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/4/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFunctions
import CoreLocation
import Firebase

class ManageLocation: UIViewController, CLLocationManagerDelegate {
    //map outlets
    @IBOutlet weak var truckLocation: MKMapView!
    
    //button outlets
    
    @IBOutlet weak var updateLocationButton: UIButton!
    @IBOutlet weak var closedButton: UIButton!
    
    
    let locationManager = CLLocationManager()
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     let locValue:CLLocationCoordinate2D = manager.location!.coordinate
     }
     var longitude = 0.0
     var latitude = 0.0
    
    override func viewDidLoad() {
        self.navigationItem.title = "Manage Your Location"
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        truckLocation.showsUserLocation = true
        truckLocation.isZoomEnabled = true
        truckLocation.isScrollEnabled = true
        setupUpdateButton()
        setupClosedButton()
        
        view.backgroundColor = UI_Colors.white
        // Do any additional setup after loading the view.
    }
    func setupUpdateButton() {
        updateLocationButton.layer.cornerRadius = 5
        updateLocationButton.layer.borderWidth = 1
        updateLocationButton.layer.borderColor = CG_Colors.red
        updateLocationButton.backgroundColor = UI_Colors.red
        updateLocationButton.setTitle("Update Location", for: .normal)
        updateLocationButton.showsTouchWhenHighlighted = true
        updateLocationButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        updateLocationButton.setTitleColor(.white, for: .normal)
    }
    func setupClosedButton() {
           closedButton.layer.cornerRadius = 5
           closedButton.layer.borderWidth = 1
           closedButton.layer.borderColor = CG_Colors.red
           closedButton.backgroundColor = UI_Colors.red
           closedButton.setTitle("Closed", for: .normal)
           closedButton.showsTouchWhenHighlighted = true
           closedButton.addTarget(self, action: #selector(closeUser), for: .touchUpInside)
           closedButton.setTitleColor(.white, for: .normal)
       }
    @objc func updateUser() {
        self.longitude = locationManager.location!.coordinate.longitude
        self.latitude = locationManager.location!.coordinate.latitude
        print(longitude)
        print(latitude)
    
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
                        self.simpleAlert(title: "Error", msg: "Unable to change location.")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
                // Do any additional setup after loading the view.
            }
        }
    }


    @objc func closeUser() {
        let user = Auth.auth().currentUser
        let nullLatitude = 0.0
        let nullLongitude = 0.0
        if let user = user {
               let uid = user.uid
               if Auth.auth().currentUser != nil {
                   let docRef = Firestore.firestore().collection("merchant").document(uid)
                   docRef.updateData([
                       "locationCoordinates": GeoPoint(latitude: nullLatitude, longitude: nullLongitude)
                   ]) { err in
                       if let err = err {
                           print("Error updating document: \(err)")
                           self.simpleAlert(title: "Error", msg: "Unable to change location.")
                       } else {
                           print("Document successfully updated")
                       }
                   }
                   
                   // Do any additional setup after loading the view.
               }
           }
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

