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

class HomePage: UIViewController,  CLLocationManagerDelegate, MKMapViewDelegate {
/*
 This method will be invoked after iOS app's view is loaded.
 */
    let map = MKMapView()
    let locationManager = CLLocationManager()
    let storage = Storage.storage()
    struct UserCoordinates {
        var longitude : Double = 0.0
        var latitude : Double = 0.0
        
        init(longitude : Double, latitude : Double) {
            self.longitude = longitude
            self.latitude = latitude
        }
    }
    var distanceArray : [Double] = []
    //var coordinatesForUser: UserCoordinates = UserCoordinates(longitude: 0.0, latitude: 0.0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: locValue, span: span)
        print(locValue.longitude)
        print(locValue.latitude)
        //self.coordinatesForUser = UserCoordinates(longitude: locValue.longitude, latitude: locValue.latitude)
        map.setRegion(region, animated: false)
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        manager.stopUpdatingLocation()
        }
    
   

    var trucksList = [Truck]()
    struct Cells {
           static let truckNames = "truckName"
       }
    var truckIdForQuery = ""
    var truckToShowMenu = ""
    var categories: [String] = [""]
    
    
    var coordinateArray = [CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let mapView = CGRect(x: 0, y: 0, width: width, height: height/2)
        map.frame = mapView
        map.showsUserLocation = true
        map.delegate = self
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        self.navigationController?.isNavigationBarHidden = true

       settupLogoInNavBar()

//
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
        locationManager.location?.coordinate.longitude
       
    userservice.updateLocation(coordinates: locationManager.location!.coordinate)
    print("the coordinates from the userservice are" , userservice.userCoordinates.latitude)

    
    let truckView = CGRect(x: 0, y: height/2,  width: width, height: height/2)
    let tableView = UITableView(frame: truckView, style: .plain)
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 150
    tableView.separatorStyle = .none
    //tableView.separatorColor = UI
    tableView.backgroundColor = UI_Colors.white
//    tableView.register(TruckItems.self, forCellReuseIdentifier: Cells.truckNames)
    tableView.register(UINib(nibName: "MainTruckCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTruckCell")
    fbCall(tableView : tableView)
    settupListner(tableView : tableView)
    
    self.view.addSubview(map)
    //print("the coordinates for the user are", coordinatesForUser)
    
   
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if(segue.identifier == "MenuSegue"){
                       let displayVC = segue.destination as! MenuPage
                       displayVC.truckIdForQuery = truckIdForQuery
                       displayVC.truckName = truckToShowMenu
                displayVC.categories = categories
               }
           }
    
    func seguetoTruckMenu(){
        self.performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    func settupLogoInNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)

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
                    //Truck.calculateDistance(latitude: , longtitude: <#T##Double#>)
                    let longitude = test.locationCoordinates.longitude
                    let latitude = test.locationCoordinates.latitude
                    let coordinateTest = MKPointAnnotation()
                    let mapCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    //loading the specific truck info into a Structure. Did this intentionally to later add hours of operation if needed
//                   
                    print("The trucks ", test.name , "distance is", test.disTance)
                    
                    
                    
                    if test.open == true  {
                    self.trucksList.append(test)
                    self.trucksList = self.trucksList.sorted(by: { $0.disTance < $1.disTance })
                    //print(sortedArray)
                    tableView.reloadData()
                        let mapData = MapData(truckName: test.name, truckCoordinates: mapCoordinates)
                        coordinateTest.coordinate = mapData.truckCoordinates
                        coordinateTest.title = mapData.truckName
                        self.map.addAnnotation(coordinateTest)
                        self.coordinateArray.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    }
                }
                print(self.trucksList)
            }
        }
    }
    func settupListner(tableView : UITableView) {
        let docRef = Firestore.firestore().collection("merchant")
        docRef.addSnapshotListener { (snap, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let test = Truck(data: data)
                let longitude = test.locationCoordinates.longitude
                let latitude = test.locationCoordinates.latitude
                let coordinateTest = MKPointAnnotation()
                let mapCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let mapData = MapData(truckName: test.name, truckCoordinates: mapCoordinates)
                if change.type == .modified {
                    //self.coordinateArray[Int(change.oldIndex)] = mapCoordinates
                    coordinateTest.coordinate = mapData.truckCoordinates
                    coordinateTest.title = mapData.truckName
                    self.map.addAnnotation(coordinateTest)
                    self.updateTruckList(truck: test, tableView: tableView)
                }
            })
        }
    }
    func updateTruckList(truck: Truck, tableView : UITableView) {
        self.trucksList.append(truck)
        self.trucksList = self.trucksList.sorted(by: { $0.disTance < $1.disTance })
        tableView.reloadData()
    }
    
}


extension HomePage: UITableViewDataSource, UITableViewDelegate {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return trucksList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MainTruckCell") as! MainTruckCellTableViewCell
//    cell.layer.borderWidth = 1.5
//    cell.layer.borderColor = CG_Colors.lightPurple
//    cell.layer.cornerRadius = 30.0
    cell.backgroundColor = UI_Colors.white
    //this line below is what creates the arrow in each tableview cell
    //cell.accessoryType = .disclosureIndicator
    cell.selectionStyle = .none
    self.trucksList.sorted(by: { $0.disTance < $1.disTance })
    let truck = trucksList[indexPath.row]
    cell.configureCell(truck: truck)
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
        self.categories = truck.categories
        seguetoTruckMenu()
    }
}
