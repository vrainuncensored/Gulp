//
//  menuItems.swift
//  
//
//  Created by Vrain Ahuja on 5/2/20.
//

import UIKit
import Firebase

class menuItems: UIViewController {
    var entreeItems = [MenuItem]()
    var sidesItems =  [MenuItem]()
    var drinksItems = [MenuItem]()
    //var tableView = UITableView()
    var testArray = [[Any]]()


    override func viewDidLoad() {
        viewWillLayoutSubviews()
        
        
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
        tableView.register(MenuItems.self, forCellReuseIdentifier: "Test")
        fbCall(tableView : tableView)

        
        
        self.navigationItem.title = "Full Menu"
        let userLogo = "person"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let userImage = UIImage(systemName: userLogo, withConfiguration: buttonConfig)
     
        
        let userLogin = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(loginAction))
        let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addAction
        navigationItem.leftBarButtonItem = userLogin

    }
     @objc func loginAction(sender: UIButton!) {
       let loginFlow = UIStoryboard(name: "LoginFlow", bundle: nil)
       let controller = loginFlow.instantiateViewController(identifier: "loginPage")
       present(controller, animated: true, completion: nil)
     }
    func printInfo(_ value: Any) {
        let t = type(of: value)
        print("'\(value)' of type '\(t)'")
    }
    func fbCall (tableView: UITableView) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            if Auth.auth().currentUser != nil {
                print( uid)
                print ( email)
                let docRef = Firestore.firestore().collection("merchant").document(uid).collection("menu")
                docRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            //print("\(document.data())")
                            let data = document.data()
                            let test = MenuItem.init(data: data)
                            if test.itemCategory == "entree" {
                                let entreeData: MenuItem = test
                                self.entreeItems.append(entreeData)
                                self.testArray.append(self.entreeItems)
                                //self.printInfo(self.entreeItems)
                                tableView.reloadData()

//                                let indexPath = IndexPath(row: 0 , section: 0)
//                                self.tableView.reloadRows(at: [indexPath], with: .right)
                                
                            }
                            else if test.itemCategory == "side" {
                                let sidesData: MenuItem = test
                                self.sidesItems.append(sidesData)
                                self.testArray.append(self.sidesItems)
                                //print(self.sidesItems)
                                tableView.reloadData()

                            }
                            else if test.itemCategory == "drink" {
                                let drinksData: MenuItem = test
                                self.drinksItems.append(drinksData)
                                self.testArray.append(self.drinksItems)
                                print(self.drinksItems)
                                tableView.reloadData()

                            }
                        }
                    }
                }
                //let test = MenuItem.init(data: [String: docRef])
                
            } else {
                print("there is NOT user")
            }
        }
        
    }
    
    @objc func addItem(sender: UIButton!) {
      self.performSegue(withIdentifier: "individalItemSegue", sender: self)
    }
    

        }


extension menuItems: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
    return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       if (section == 0){
            return "entrees"
        }
        if (section == 1){
            return "sides"
        }
        if (section == 2 ){
            return "drinks"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return entreeItems.count
        }
        if (section == 1){
            return sidesItems.count
        }
        if (section == 2){
            return drinksItems.count
        }
        return 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! MenuItems
        if (indexPath.section == 0){
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            let item = entreeItems[indexPath.row]
            cell.set(item: item)
            reloadInputViews()

            
        }
        if (indexPath.section == 1){
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            let item = sidesItems[indexPath.row]
            cell.set(item: item)
            reloadInputViews()

        }
        if (indexPath.section == 2){
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            let item = drinksItems[indexPath.row]
            cell.set(item: item)
            reloadInputViews()

        }
        


        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = items[indexPath.section][indexPath.row]
//        itemSelected = item.itemName
//        priceSelected = item.price
//        //        self.performSegue(withIdentifier: "confirmationSegue", sender: self)
//    }

}



