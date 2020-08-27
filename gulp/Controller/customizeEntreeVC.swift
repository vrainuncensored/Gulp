//
//  customizeEntreeVC.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase

class customizeEntreeVC: UIViewController, UITextViewDelegate {
    var entreeItemSelected: String?
    var truckForFBQuery: String?
    var proteinOption = [MenuItem]()
    var addOnOptions = [MenuItem]()
    var allAddOnOptions = [[Any]]()
    //var customerRequests = UITextField()
    //let checkOutButton = UIButton()
    
    //TableView Outlets
    @IBOutlet weak var itemOptions: UITableView!
    
    //UITextField Outlets
    
    @IBOutlet weak var customerRequests: UITextView!
    // @IBOutlet weak var customerRequests: UITextField!
    //Button Outlets
    
    @IBOutlet weak var checkOutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //let test = CGRect(x: width/2, y: height * (1/8), width: width/10, height: height/8)
       // entreeLabel.frame = test
        
        customerRequests.layer.cornerRadius = 5
        customerRequests.layer.borderWidth = 2
        customerRequests.layer.borderColor = CG_Colors.lightPurple

        
        checkOutButton.setTitle("Login in", for: .normal)
        checkOutButton.showsTouchWhenHighlighted = true
        checkOutButton.layer.cornerRadius = 5
        checkOutButton.layer.borderWidth = 1
        checkOutButton.layer.borderColor = CG_Colors.darkPurple
        checkOutButton.layer.backgroundColor = CG_Colors.darkPurple
        
        
//        let customizeView = CGRect(x: 0, y:  height/3,  width: width, height: height/3)
//        view.addSubview(tableView)
//
      
        
        customerRequests.autocapitalizationType = UITextAutocapitalizationType.none
        customerRequests.borderStyle = UITextField.BorderStyle.none
        customerRequests.attributedPlaceholder = NSAttributedString(string:"Please add any notes for the chef", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        customerRequests.adjustsFontSizeToFitWidth = true
//        entreeLabel.text = "\(entreeItemSelected!)"
//        self.view.addSubview(entreeLabel)
//        entreeLabel.translatesAutoresizingMaskIntoConstraints = false
//        entreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        entreeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
//        entreeLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
//
        self.navigationItem.title = "\(self.entreeItemSelected!)"
       
        
        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        //tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //tableView.bottomAnchor.constraint(equalTo: customerRequests.topAnchor, constant: 10).isActive = true
//        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
//        tableView.heightAnchor.constraint(equalToConstant: height/3).isActive = true
//
//        customerRequests.translatesAutoresizingMaskIntoConstraints = false
//        customerRequests.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
//        customerRequests.bottomAnchor.constraint(equalTo: checkOutButton.topAnchor, constant: 300).isActive = true
//        //customerRequests.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        customerRequests.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
//        customerRequests.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 100).isActive = true
////
//        checkOutButton.translatesAutoresizingMaskIntoConstraints = false
//        //checkOutButton.topAnchor.constraint(equalTo: customerRequests.bottomAnchor, constant: 300).isActive = true
//        checkOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
//        checkOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        checkOutButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10).isActive = true
//        checkOutButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//
//       checkOutButton.heightAnchor.constraint(equalToConstant: height/6).isActive = true
//        checkOutButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
//
        
        
        
        
        customerRequests.delegate = self
        itemOptions.dataSource = self
        itemOptions.delegate = self
        itemOptions.allowsMultipleSelection = true
        itemOptions.allowsMultipleSelectionDuringEditing = true
        itemOptions.rowHeight = 75
        itemOptions.register(MenuItems.self, forCellReuseIdentifier: "Test")
        fbCall(tableView: itemOptions)
        //userservice.updateCart
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                     if(segue.identifier == "segueToCustomizeEntreeVC"){
                             let displayVC = segue.destination as! customizeEntreeVC
                           //  displayVC.entreeItemSelected = entreeSelected
                           //  displayVC.truckForFBQuery = self.truckIdForQuery!
                             displayVC.modalPresentationStyle = .fullScreen
                     }
                 }
       
    @objc func segueToUserCartPage(){
                  self.performSegue(withIdentifier: "userCartSegue", sender: self)
       }
    func fbCall (tableView: UITableView) {
        let docRef = Firestore.firestore().collection("merchant").document("\(self.truckForFBQuery!)").collection("menuAddOns")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.data())")
                    let data = document.data()
                    let test = MenuItem.init(data: data)
                    if test.itemCategory == "Protein" {
                        let proteinData: MenuItem = test
                        self.proteinOption.append(proteinData)
                        self.allAddOnOptions.append(self.proteinOption)
                        //self.printInfo(self.entreeItems)
                        tableView.reloadData()
                        
                        //                                let indexPath = IndexPath(row: 0 , section: 0)
                        //                                self.tableView.reloadRows(at: [indexPath], with: .right)
                        
                    }
                    else if test.itemCategory == "Add ons" {
                        let addOnData: MenuItem = test
                        self.addOnOptions.append(addOnData)
                        self.allAddOnOptions.append(self.addOnOptions)
                        //print(self.sidesItems)
                        tableView.reloadData()
                        
                    }
                }
            }
        }
        //let test = MenuItem.init(data: [String: docRef])
    }
}

extension customizeEntreeVC: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! MenuItems
        if (indexPath.section == 0){
            let item = proteinOption[indexPath.row]
            cell.set(item: item)
            reloadInputViews()

            
        }
        if (indexPath.section == 1){
            let item = addOnOptions[indexPath.row]
            cell.set(item: item)
            reloadInputViews()

        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuItems
        if cell.itemLabel.text != "" {
            print(cell.itemLabel.text ?? "hello")
        }
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Choice of Protein"
        }
        if (section == 1){
            return "Add ons"
        }
        
        return ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return proteinOption.count
        }
        if (section == 1){
            return addOnOptions.count
        }
        
        return 0
    }
     func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
extension customizeEntreeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
