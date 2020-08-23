import UIKit
import Firebase

class MenuPage: UIViewController {
    /*
     This method will be invoked after iOS app's view is loaded.
     */
    let cart = shoppingCart.items
    var entreeItems = [MenuItem]()
    var sidesItems =  [MenuItem]()
    var drinksItems = [MenuItem]()
    var testArray = [[Any]]()
    var entreeSelected = ""
    struct Cells {
        static let menuItem = "MenuItems"
    }
    var itemSelected: String!
    var priceSelected: String!
    var truckIdForQuery: String?
    var truckName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewWillLayoutSubviews()
        
        Functions.functions().httpsCallable("notify").call{(result, error) in
                   if let error = error {
                       debugPrint(error.localizedDescription)
                       self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                       return
                   }
                   //this is the code that has been executed for after a successful charge has been made
                  print("success")
            }  
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let tableFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let tableView = UITableView(frame: tableFrame, style: .grouped)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(MenuItems.self, forCellReuseIdentifier: "Test")
        fbCall(tableView: tableView)
        
        self.navigationItem.title = "\(truckName!)'s menu"
               let userLogo = "cart.badge.plus"
               let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
               let userImage = UIImage(systemName: userLogo, withConfiguration: buttonConfig)
            
               
               let addToCartNavButton = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(addToCart))
               let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(test1))
               //navigationItem.rightBarButtonItem = addAction
               navigationItem.rightBarButtonItem = addToCartNavButton
        
        
        
        
      
    }
    func fbCall (tableView: UITableView) {
        
        let docRef = Firestore.firestore().collection("merchant").document("\(self.truckIdForQuery!)").collection("menu")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.data())")
                    let data = document.data()
                    let test = MenuItem.init(data: data)
                    if test.itemCategory == "entrees" {
                        let entreeData: MenuItem = test
                        self.entreeItems.append(entreeData)
                        self.testArray.append(self.entreeItems)
                        //self.printInfo(self.entreeItems)
                        tableView.reloadData()
                        
                        //                                let indexPath = IndexPath(row: 0 , section: 0)
                        //                                self.tableView.reloadRows(at: [indexPath], with: .right)
                        
                    }
                    else if test.itemCategory == "sides" {
                        let sidesData: MenuItem = test
                        self.sidesItems.append(sidesData)
                        self.testArray.append(self.sidesItems)
                        //print(self.sidesItems)
                        tableView.reloadData()
                        
                    }
                    else if test.itemCategory == "drinks" {
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
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  if(segue.identifier == "segueToCustomizeEntreeVC"){
                          let displayVC = segue.destination as! customizeEntreeVC
                          displayVC.entreeItemSelected = entreeSelected
                          displayVC.truckForFBQuery = self.truckIdForQuery!
                          displayVC.modalPresentationStyle = .fullScreen
                  }
              }
    
    @objc func loginAction() {
          let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
          let controller = loginFlow.instantiateViewController(identifier: "loginPage")
          present(controller, animated: true, completion: nil)
        }

    func segueToUserCartPage(){
        self.performSegue(withIdentifier: Segues.ToUserCart, sender: self)
    }
    func segueToEntreeCustomizePage(){
               self.performSegue(withIdentifier: "segueToCustomizeEntreeVC", sender: self)
    }
   
    @objc func addToCart () {
       if Auth.auth().currentUser != nil {
        self.segueToUserCartPage()
        if userservice.userListner == nil {
            userservice.getUser()
        }
       } else {
         let signUpMessage = "Let's get you signed in so you can order from \(self.truckName!)"
         let alertController = UIAlertController(title: "Please sign in", message: signUpMessage, preferredStyle: .alert)
         let action1 = UIAlertAction(title: "Sign In", style: .default) { (action:UIAlertAction) in
            self.loginAction()
         }
         alertController.addAction(action1)
         self.present(alertController, animated: true, completion: nil)
       }
    }
     
    
    
    
    
    
    @objc func test1 () {
          let alertController = UIAlertController(title: "Alert", message: "This is an alert.", preferredStyle: .alert)
          let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
              print("You've pressed default");
          }
          let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
              print("You've pressed cancel");
          }
          let action3 = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
              print("You've pressed the destructive");
          }
          alertController.addAction(action1)
          alertController.addAction(action2)
          alertController.addAction(action3)
          self.present(alertController, animated: true, completion: nil)
    
      }

}
extension MenuPage: UITableViewDataSource, UITableViewDelegate {
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
            let item = entreeItems[indexPath.row]
            cell.set(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            //this line below is what creates the arrow in each tableview cell
            cell.accessoryType = .disclosureIndicator
            reloadInputViews()

            
        }
        if (indexPath.section == 1){
            let item = sidesItems[indexPath.row]
            cell.set(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            //this line below is what creates the arrow in each tableview cell
            cell.accessoryType = .disclosureIndicator
            reloadInputViews()

        }
        if (indexPath.section == 2){
            let item = drinksItems[indexPath.row]
            cell.set(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            //this line below is what creates the arrow in each tableview cell
            cell.accessoryType = .disclosureIndicator
            reloadInputViews()

        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.truckNames) as! TruckItems
        //        cell.menuButton.tag = indexPath.row
        //        cell.menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        //            reloadInputViews()
        //          tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let entreeSelected = entreeItems[indexPath.row]
            self.entreeSelected = entreeSelected.name
            
            self.segueToEntreeCustomizePage()
        }
        if indexPath.section == 1 {
            let sideSelected = sidesItems[indexPath.row]
           shoppingCart.add(item: sideSelected)
            print(sideSelected.price)
            print(shoppingCart.totalCost)
        }
        if indexPath.section == 2 {
            let drinkSelected = drinksItems[indexPath.row]
            shoppingCart.add(item: drinkSelected)
            print(shoppingCart.items)
        }
        let cell = tableView.cellForRow(at: indexPath) as! MenuItems
        
        if cell.itemLabel.text != "" {
            print(cell.itemLabel.text ?? "hello")
        }
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          let cell = tableView.cellForRow(at: indexPath) as! MenuItems
              if cell.itemLabel.text != "" {
                  print(cell.itemLabel.text ?? "hello")
              }
    }
        
    }

        
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
           return true
    }
        
        
//            let truck = trucksList[indexPath.row]
//            self.truckIdForQuery = truck.id
//            self.truckToShowMenu = truck.name
//            seguetoTruckMenu()
//        }


