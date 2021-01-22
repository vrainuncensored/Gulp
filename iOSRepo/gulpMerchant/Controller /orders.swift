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
import FirebaseAuth

class orders: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    }
    var longitude = 0.0
    var latitude = 0.0
    
    var listOfOrders = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        print(listOfOrders)
        
        //self.longitude = locationManager.location!.coordinate.longitude
        //self.latitude = locationManager.location!.coordinate.latitude
        //fbCall(latitude: latitude, longitude: longitude)
    
        
        self.navigationItem.title = "Orders"
        let userLogo = "person"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let userImage = UIImage(systemName: userLogo, withConfiguration: buttonConfig)
        
        
        let userLogin = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(addItem))
        let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(segueTo))
        navigationItem.rightBarButtonItem = addAction
        navigationItem.leftBarButtonItem = userLogin
        
        
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let tableFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let tableView = UITableView(frame: tableFrame, style: .grouped)
        tableView.frame = tableFrame
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(ordersTableViewCell.self, forCellReuseIdentifier: "Test")
        
        fbCallOrders(tableView: tableView)
        
        
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
    
    func fbCallOrders (tableView: UITableView) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            if Auth.auth().currentUser != nil {
                print( uid)
                print ( email)
                let docRef = Firestore.firestore().collection("merchant").document(uid).collection("orders")
                docRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            //print("\(document.data())")
                            let data = document.data()
                            let orderfromFB = Order.init(data: data)
                            self.listOfOrders.append(orderfromFB)
                            tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    @objc func addItem(sender: UIButton!) {
        self.performSegue(withIdentifier: "individalItemSegue", sender: self)
      }
    @objc func segueTo(sender: UIButton!) {
        self.performSegue(withIdentifier: "toConfirmationPage", sender: self)    }
}

extension orders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfOrders.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return("Incoming Orders")
        }
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! ordersTableViewCell
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
        if listOfOrders.count == 0 {
            reloadInputViews()
            return cell
        } else {
            let item = listOfOrders[indexPath.row]
            cell.set(item: item)
            reloadInputViews()
            return cell
            
    }
    
    
}
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath){
         
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.truckNames) as! TruckItems
//        cell.menuButton.tag = indexPath.row
//        cell.menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        reloadInputViews()
//      tableView.deselectRow(at: indexPath, animated: true)
//        let truck = trucksList[indexPath.row]
//        self.truckIdForQuery = truck.id
//        self.truckToShowMenu = truck.name
//        seguetoTruckMenu()
//    }

}
