//
//  Homepage.swift
//  gulp
//
//  Created by Vrain Ahuja on 3/31/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class HomePage: UIViewController,  CLLocationManagerDelegate {
/*
 This method will be invoked after iOS app's view is loaded.
 */
    let map = MKMapView()
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: false)
        }
    var trucksList = [Truck]()
    struct Cells {
           static let truckNames = "truckName"
       }
    var truckIdForQuery = ""
    var truckToShowMenu = ""
    
    
    
    var coordinateArray = [CLLocationCoordinate2D]()

    
    override func viewDidLoad() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let mapView = CGRect(x: 0, y: 0, width: width, height: height/2)
        map.frame = mapView
        map.showsUserLocation = true
        
        

    

    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
    

    
    

    
    let truckView = CGRect(x: 0, y: height/2,  width: width, height: height/2)
    let tableView = UITableView(frame: truckView, style: .plain)
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 100
    tableView.register(TruckItems.self, forCellReuseIdentifier: Cells.truckNames)
    fbCall(tableView : tableView)
           

    
    
    
    
//
//    for truck in trucks {
//       let truckButton = UIButton(frame: CGRect(x : 0, y: 0, width : 250, height: 10))
//        truckButton.setTitleColor(.black, for: .normal)
//        truckButton.backgroundColor = .clear
//        truckButton.layer.cornerRadius = 7
//        truckButton.layer.borderWidth = 3
//        truckButton.layer.borderColor = UIColor.purple.cgColor
//        //truckButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//    }
    

    
    self.view.addSubview(map)
   
    
   
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if(segue.identifier == "MenuSegue"){
                       let displayVC = segue.destination as! MenuPage
                       displayVC.truckIdForQuery = truckIdForQuery
                displayVC.truckName = truckToShowMenu
               }
           }
    
    func seguetoTruckMenu(){
           self.performSegue(withIdentifier: "MenuSegue", sender: self)
}
    func fbCall (tableView : UITableView) {
        let docRef = Firestore.firestore().collection("merchant")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                   let data = document.data()
                    let test = Truck(data: data)
                    self.coordinateArray.append(test.locationCoordinates)
                    self.trucksList.append(test)
                    tableView.reloadData()
                    
                }
                
            }
        }
    }
    
    
}

extension HomePage: UITableViewDataSource, UITableViewDelegate {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return trucksList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Cells.truckNames) as! TruckItems
    let truck = trucksList[indexPath.row]
    cell.set(item: truck)
    reloadInputViews()
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.truckNames) as! TruckItems
//        cell.menuButton.tag = indexPath.row
//        cell.menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        reloadInputViews()
      tableView.deselectRow(at: indexPath, animated: true)
        let truck = trucksList[indexPath.row]
        self.truckIdForQuery = truck.id
        self.truckToShowMenu = truck.name
        seguetoTruckMenu()
    }
}
