//
//  PastOrdersVC.swift
//  gulp
//
//  Created by vrain ahuja on 2/3/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PastOrdersVC: UIViewController {


    @IBOutlet weak var PastOrdersTableView: UITableView!
    @IBOutlet weak var SignOutButton: UIButton!
    var sectionNames : [String: Any] = ["": ""]
    
    var listOfOrders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        settupSignOutButton()
        settupTableView()
        settupNavigationBar()
        testoutFBCall()
        settupShareButton()
        //fbCallOrders(tableView: PastOrdersTableView)
        // Do any additional setup after loading the view.
    }
    func testoutFBCall() {
        let docRef = Firestore.firestore().collection("users").document("gPUfEeut8vTEoXOCEQJZh6PWobj2").collection("orders")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let orderfromFB = Order.init(data: data)
                    self.listOfOrders.append(orderfromFB)
                    self.PastOrdersTableView.reloadData()
                }
            }
        }
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
    func settupShareButton() {
        let shareLogo = "square.and.arrow.up"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let userImage = UIImage(systemName: shareLogo, withConfiguration: buttonConfig)
        let addToCartNavButton = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(shareFunction(_:)))
        navigationItem.rightBarButtonItem = addToCartNavButton

    }
    func settupSignOutButton() {
        SignOutButton.addTarget(self, action: #selector(SignOutFunction), for: .touchUpInside)
        SignOutButton.setTitle("Sign Out", for: .normal)
        SignOutButton.showsTouchWhenHighlighted = true
        SignOutButton.layer.cornerRadius = 5
        SignOutButton.layer.borderWidth = 1
        SignOutButton.layer.borderColor = CG_Colors.red
        SignOutButton.layer.backgroundColor = CG_Colors.red
        SignOutButton.setTitleColor(.white, for: .normal)
    }
    func settupTableView() {
        PastOrdersTableView.delegate = self
        PastOrdersTableView.dataSource = self
        PastOrdersTableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersTableViewCell")
        PastOrdersTableView.separatorStyle = .none
        PastOrdersTableView.rowHeight = 100
        PastOrdersTableView.backgroundColor = UI_Colors.white
    }
    func settupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UI_Colors.white
    }
    @objc func shareFunction(_ sender: UIButton){
        print("hey ho, let's go")
        // Setting description
            let firstActivityItem = "Hey, I used Gulp to order from my favorite foodtruck! Download now to locate your favorite truck and order ahead🤓"

            // Setting url
            let secondActivityItem : URL = URL(string: "https://www.ordergulp.com/")!
            
            // If you want to use an image
        let image : UIImage = UIImage(named: "16")!
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
            
////            // This lines is for the popover you need to show in iPad
//            activityViewController.popoverPresentationController?.sourceView = sender
//
//            // This line remove the arrow of the popover to show in iPad
//            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
//            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
//
//            // Pre-configuring activity items
//            activityViewController.activityItemsConfiguration = [
//            UIActivity.ActivityType.message
//            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                //UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
    }

    @objc func SignOutFunction(){
        let firebaseAuth = Auth.auth()
       do {
         userservice.logoutUser()
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
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
extension PastOrdersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell
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
            let item = listOfOrders[indexPath.row]
            cell.configureCell(order: item)
            reloadInputViews()
            return cell
        }
        return cell
    }
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//                let headerView = UIView()
//                headerView.backgroundColor = UIColor.lightGray
//
//                let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
//                    tableView.bounds.size.width, height: tableView.bounds.size.height))
//                headerLabel.font = UIFont(name: "Verdana", size: 20)
//                headerLabel.textColor = UIColor.white
//                headerLabel.text = "Testing THis ou"
//                headerLabel.sizeToFit()
//                headerView.addSubview(headerLabel)
//
//                return headerView
//            }
//
//         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 40
//        }
    
    
}
