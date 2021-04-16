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
    var entreeItemSelected: MenuItem = MenuItem(selectionChoice: Selection(required: true, name: "", selectionNumber: "", options: [SelectionOption()]))
    var optionsSelected : [SelectionOption] = [SelectionOption()]
    //var test : MenuItem = MenuItem( selectionChoice: Selection())
    var truckForFBQuery: String?
    var proteinOption = [MenuItem]()
    var addOnOptions = [MenuItem]()
    var allAddOnOptions = [[Any]]()
    
    var quantityOfItems: Int = 1
    //var customerRequests = UITextField()
    //let checkOutButton = UIButton()
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    //Label Outlets
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    //TableView Outlets
    @IBOutlet weak var itemOptions: UITableView!
    
    //UITextField Outlets
    @IBOutlet weak var customerRequests: UITextField!
 
    //Button Outlets
    @IBOutlet weak var checkOutButton: UIButton!
    
    @IBAction func quantityStepper(_ sender: UIStepper) {
//        if sender.value == 0 {
//        self.quantityOfItems = 1
//        }
        quantityValueLabel.text = String(sender.value)
        self.quantityOfItems = Int(sender.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addBackground()
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
   
        settupCheckOutButton()
        settupCustomerRequestTextField()
        settupItemLabels()
        //print(entreeItemSelected.selectionChoice.options)
        stepperOutlet.minimumValue = 0
        print(entreeItemSelected.selectionChoice.options.count)
        print(entreeItemSelected.selectionChoice.options)
        
        self.navigationItem.title = "\(self.entreeItemSelected.name)"
        self.view.backgroundColor = UI_Colors.white
        
        itemOptions.dataSource = self
        itemOptions.delegate = self
        itemOptions.allowsMultipleSelection = true
        itemOptions.allowsMultipleSelectionDuringEditing = true
        itemOptions.rowHeight = 75
        itemOptions.register(MenuItems.self, forCellReuseIdentifier: "Test")
        itemOptions.backgroundColor = UI_Colors.white
        
        stepperOutlet.backgroundColor = UI_Colors.lightPurple
        stepperOutlet.layer.cornerRadius = 10
        //print(entreeItemSelected)
        fbCall(tableView: itemOptions)
        
        //print (self.entreeItemSelected.selectionChoice.options)
        
    }
    func settupCheckOutButton() {
        checkOutButton.addTarget(self, action: #selector(updateCustomize), for: .touchUpInside)
        checkOutButton.setTitle("Add To Cart", for: .normal)
        checkOutButton.showsTouchWhenHighlighted = true
        checkOutButton.layer.cornerRadius = 5
        checkOutButton.layer.borderWidth = 1
        checkOutButton.layer.borderColor = CG_Colors.red
        checkOutButton.layer.backgroundColor = CG_Colors.red
        checkOutButton.setTitleColor(.white, for: .normal)
    }
    func settupItemLabels() {
        itemLabel.text = entreeItemSelected.name
        itemDescription.text = entreeItemSelected.description
    }
    func settupCustomerRequestTextField() {
        customerRequests.layer.cornerRadius = 5
        customerRequests.layer.borderWidth = 2
        customerRequests.layer.borderColor = CG_Colors.lightPurple
        customerRequests.backgroundColor = UI_Colors.white
        customerRequests.autocapitalizationType = UITextAutocapitalizationType.none
        customerRequests.attributedPlaceholder = NSAttributedString(string:"Please add any notes for the chef", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        customerRequests.delegate = self
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
    @objc func updateCustomize(){
        shoppingCart.additionalRequests = self.customerRequests.text ?? ""
        self.simpleAlert(title: "Customization Completed" , msg: "We have your changes to the entree")
        let item = CartItem(item: entreeItemSelected, quantity: quantityOfItems, additionalComments: customerRequests.text ?? "", options: optionsSelected)
        print(item.additionalComments)
        print(item.options)
        print(item.SubTot)
        shoppingCart.add(item: item)
        for item in shoppingCart.items {
            print (item.subTotal)
            print (quantityOfItems)
        }
        
        //print(shoppingCart.subtotal)

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
//                    let testValue = data["selection"]  as! Dictionary<String, Any>
//                    let selectionTest = testValue["name "] as! String
//                    let selectionBool = testValue["required"] as! Bool
//                    let selectionNum = testValue["selectionNumber"] as! String
                    let sel = Selection(data: data)
                    let test = MenuItem.init(data: data, selection: sel)
                    if test.itemCategory == "Protein Options" {
                        let proteinData: MenuItem = test
                        self.proteinOption.append(proteinData)
                        self.allAddOnOptions.append(self.proteinOption)
                        //self.printInfo(self.entreeItems)
                        tableView.reloadData()
                        
                        //                                let indexPath = IndexPath(row: 0 , section: 0)
                        //                                self.tableView.reloadRows(at: [indexPath], with: .right)
                        
                    }
                        if test.itemCategory == "Add ons" {
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
//        if entreeItemSelected.options?.count == 0 {
//            return 1
//        } else {
//            return 2
//        }
        return 1
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! MenuItems
        let item = entreeItemSelected.selectionChoice.options[indexPath.row]
        cell.set(item: item)
        reloadInputViews()
//        if (indexPath.section == 0){
//            let item = entreeItemSelected.selectionChoice.options[indexPath.row]
//            //let item = proteinOption[indexPath.row]
//            print(item)
//            cell.set(item: item)
//           // cell.set(item: item)
//            cell.backgroundColor = UI_Colors.white
//            reloadInputViews()
//
//
//        }
//        if (indexPath.section == 1){
//            if entreeItemSelected.options?.count == 0 {
//                return UITableViewCell()
//            } else {
//            let item = entreeItemSelected.toppings![indexPath.row]
//           // let item = addOnOptions[indexPath.row]
//            //cell.set(item: item)
//            cell.configure(item: item)
//            cell.backgroundColor = UI_Colors.white
//
//            reloadInputViews()
//            }
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuItems
        cell.accessoryType = .disclosureIndicator
        
        let item = entreeItemSelected.selectionChoice.options[indexPath.row]
        print(item.name)
        optionsSelected.append(item)
//        if indexPath.section == 0 {
//                   let choiceOfProteinSelected = proteinOption[indexPath.row]
//            //shoppingCart.add(item: choiceOfProteinSelected)
//                   print(shoppingCart.items)
//               }
//        if indexPath.section == 1 {
//                   let addOnSelected = addOnOptions[indexPath.row]
//            //shoppingCart.add(item: addOnSelected)
//                   print(shoppingCart.items)
//               }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuItems
        cell.accessoryType = .disclosureIndicator
        
        let item = entreeItemSelected.selectionChoice.options[indexPath.row]
        print(item.name)
        //let index = optionsSelected.firstIndex{$0 === item}
        //let indexOfA = optionsSelected.firstIndex(of: item) // 0
        let index = optionsSelected.firstIndex(where: { (items) -> Bool in
            items.name == item.name // test if this is the item you're looking for
        })
        optionsSelected.remove(at: index!)
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (section == 0){
//            return "Options"
//        }
//        if (section == 1){
//            return "Toppings"
//        }
//
        return entreeItemSelected.selectionChoice.name

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section == 0){
//            return entreeItemSelected.selectionChoice.options.count
//        }
//        if (section == 1){
//            return entreeItemSelected.toppings?.count ?? 0
//        }
//
        return entreeItemSelected.selectionChoice.options.count
    }
     func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}
extension customizeEntreeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
