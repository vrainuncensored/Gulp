//
//  CompletedOrdersViewController.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 1/27/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CompletedOrdersViewController: UIViewController {
    
    
    var confirmedOrders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.view.backgroundColor = UI_Colors.white
        
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
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(ordersTableViewCell.self, forCellReuseIdentifier: "Test")
        fbCallOrders(tableView: tableView)
        // Do any additional setup after loading the view.
    }
    func fbCallOrders (tableView: UITableView) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            if Auth.auth().currentUser != nil {
                print( uid)
                print ( email)
                let docRef = Firestore.firestore().collection("merchant").document(uid).collection("completedOrders")
                docRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            //print("\(document.data())")
                            let data = document.data()
                            let orderfromFB = Order.init(data: data)
                            self.confirmedOrders.append(orderfromFB)
                            tableView.reloadData()
                        }
                    }
                }
                docRef.addSnapshotListener { (snap, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in snap!.documents {
                            //print("\(document.data())")
                            let data = document.data()
                            let orderfromFB = Order.init(data: data)
                            self.confirmedOrders.append(orderfromFB)
                            tableView.reloadData()
                        }
                    }
                }
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

extension CompletedOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return confirmedOrders.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return("Confirmed Orders 🚀")
        }
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! ordersTableViewCell
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
        if confirmedOrders.count == 0 {
            reloadInputViews()
            return cell
        } else {
            let item = confirmedOrders[indexPath.row]
            cell.set(item: item)
            reloadInputViews()
            return cell
            
    }

    
    
}
}
