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
    
    var spacingConstant : CGFloat = 1
    var listOfOrders = [Order]()
    
    var orderSpecifics : Order = Order(data: ["any": "any"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Incoming Orders"
//        self.navigationController?.navigationBar.titleTextAttributes = tabFontAttributes as [NSAttributedString.Key : Any]
//        let attributes = [NSAttributedString.Key.font: UIFont(name: fonts.righteous, size: 17)!]
//        UINavigationBar.appearance().titleTextAttributes = attributes
        let archivesSFSymbol = "scroll"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let archiveImage = UIImage(systemName: archivesSFSymbol, withConfiguration: buttonConfig)
        
        
        let archiveButton = UIBarButtonItem(image: archiveImage, style: .plain, target: self, action: #selector(addItem))
       // let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(segueTo))
        navigationItem.rightBarButtonItem = archiveButton
        //navigationItem.leftBarButtonItem = userLogin
        
        
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let tableFrame = CGRect(x: (width - (width - 10)), y: 0, width: width - 20, height: height)
        let tableView = UITableView(frame: tableFrame, style: .grouped)
        tableView.frame = tableFrame
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersTableViewCell")
        view.backgroundColor = UI_Colors.white
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        fbCallOrders(tableView: tableView)
        settupListner (tableView : tableView)
        reloadInputViews()
        tableView.reloadData()
        
        }
        
   
   
    
    func fbCallOrders (tableView: UITableView) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            if Auth.auth().currentUser != nil {
                let docRef = Firestore.firestore().collection("merchant").document(uid).collection("orders")
                docRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
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
    func settupListner (tableView : UITableView) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            if Auth.auth().currentUser != nil {
                
                let docRef = Firestore.firestore().collection("merchant").document(uid).collection("orders")
                docRef.addSnapshotListener { (snap, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                        return
                    }
                    
                    snap?.documentChanges.forEach({ (change) in
                        
                        let data = change.document.data()
                        let order = Order.init(data: data)
                        
                        if change.type == .removed {
                            self.listOfOrders.remove(at: Int(change.oldIndex))
                            tableView.deleteRows(at: [IndexPath(item: Int(change.oldIndex), section: 0)], with: .fade)
                            tableView.reloadData()
                        }
                        if change.type == .added {
                            self.listOfOrders.append(order)
                            tableView.reloadData()
                        }
                    })
                }
            }
        }
    }
    @objc func addItem(sender: UIButton!) {
        self.performSegue(withIdentifier: "segueToCompletedOrders", sender: self)
      }
    @objc func segueTo(sender: UIButton!) {
        self.performSegue(withIdentifier: "toConfirmationPage", sender: self)    }
    func segueToOrderConfirmation () {
        self.performSegue(withIdentifier: "toConfirmationPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if(segue.identifier == "toConfirmationPage"){
                       let displayVC = segue.destination as! OrderConfirmation
                       displayVC.orderInformation = orderSpecifics
               }
           }
}

extension orders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = CG_Colors.white
        cell.layer.cornerRadius = 4
        cell.backgroundColor = UI_Colors.white
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 5, height: 0)
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 4.0
        if listOfOrders.count == 0 {
            reloadInputViews()
            return cell
        } else {
            let item = listOfOrders[indexPath.section]
            cell.configureCell(order: item)
            reloadInputViews()
            return cell
        }
}
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return spacingConstant
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let specificOrder = listOfOrders[indexPath.section]
        self.orderSpecifics = specificOrder
        segueToOrderConfirmation()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let headerView = UIView()
        // 2
        headerView.backgroundColor = view.backgroundColor
        // 3
        return headerView
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let specificOrder = listOfOrders[indexPath.row]
//        self.orderSpecifics = specificOrder
//        segueToOrderConfirmation()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//          let specificOrder = listOfOrders[indexPath.row]
//        self.orderSpecifics = specificOrder
//          segueToOrderConfirmation()
    
    
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
