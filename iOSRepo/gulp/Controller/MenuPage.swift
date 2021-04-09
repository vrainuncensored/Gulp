import UIKit
import Firebase
import FirebaseAuth
class MenuPage: UIViewController {
    /*
     This method will be invoked after iOS app's view is loaded.
     */
    let cart = shoppingCart.items
    var entreeItems = [MenuItem]()
    var sidesItems =  [MenuItem]()
    var drinksItems = [MenuItem]()
    var menuMap : Dictionary<String, [String]> = Dictionary()
    var multiArray : [[String]] = [[String]]()
    var anArray = [MenuItem]()
    var testArray = [[Any]]()
    var entreeSelected: MenuItem = MenuItem( selectionChoice: Selection(required: true, name: "", selectionNumber: "", options: [SelectionOption()]))
    struct Cells {
        static let menuItem = "MenuItems"
    }
    var itemSelected: String!
    var priceSelected: String!
    var truckIdForQuery: String?
    var truckName: String?
    var categories : [String]?
    var categorieNames: [String] = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        //viewWillLayoutSubviews()
        truckservice.getTruck(UUID: truckIdForQuery!)
        
        print(userservice.isGuest)
        print(userservice.user.email)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let tableFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let tableView = UITableView(frame: tableFrame, style: .grouped)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = UI_Colors.white
        
        //tableView.register(MenuItems.self, forCellReuseIdentifier: "Test")
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        fbCall(tableView: tableView)
        
        self.navigationItem.title = "\(truckName!)'s menu"
        let userLogo = "cart.badge.plus"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let userImage = UIImage(systemName: userLogo, withConfiguration: buttonConfig)
        
        
        let addToCartNavButton = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(addToCart))
        let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(test1))
        navigationItem.rightBarButtonItem = addToCartNavButton
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        
      
    }
    func fbCall (tableView: UITableView) {
        
        let docRef = Firestore.firestore().collection("merchant").document("\(self.truckIdForQuery!)").collection("menu")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let testValue = data["selection"]  as! Dictionary<String, Any>
                    let selections = testValue["selections"] as! [Dictionary<String, Any>]
                    let sectionTest: () = print(selections[0])
                    let value = type(of: sectionTest)
                    let sel = Selection(data: data)
                    var test = MenuItem.init(data: data, selection: sel)
                    for item in selections {
                        let name = item["name"] as! String
                        let description = item["description"] as! String
                        print(name)
                        print(description)
                        let specificItem = SelectionOption(price: 1.0, name: name, description: description)
                        test.selectionChoice.options.append(specificItem)
                        self.anArray.append(test)
                        
                    }
                    //print(value)
//                    let name = test.name
//                    let category = test.itemCategory
//                    if let category = self.menuMap[category] {
//                        self.menuMap[category]!.append(name)
//                    } else {
//                        self.menuMap[category] = self.menuMap[name]
//                    }
                    //print(testValue)
                    
//                    if self.menuMap.keys.contains(category) {
//                        self.menuMap[category]!.append(name)
//                    } else {
//                      // create new list
//                        self.menuMap[category] = [name]
//                    }
//
                    //print(self.menuMap)

                    //print(self.anArray)
                    tableView.reloadData()

                    
                    if test.itemCategory == "entrees" {
                        let entreeData: MenuItem = test
                        self.entreeItems.append(entreeData)
                        self.testArray.append(self.entreeItems)
                        tableView.reloadData()
                        
//                                                let indexPath = IndexPath(row: 0 , section: 0)
//                                                    self.tableView.reloadRows(at: [indexPath], with: .right)
                        
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
                        //print(self.drinksItems)
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
        return categorieNames[section] as? String ?? "Hello"
//        return categories![section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        for category in categories! {
//            var value = 0
//            var count = 0
//            if section == value{
//            for items in self.anArray {
//                if items.itemCategory == category {
//                    count = count + 1
//                }
//            }
//                return count
//            }
//            value = value + 1
//        }
//
//            if self.menuMap.keys.contains("drinks") {
//                return self.menuMap["drinks"]!.count
//            } else {
//              // create new list
//            print("empty")
//            }
    

//        if categories?.isEmpty == false {
//        let value = categories![section]
//            print(value)
//            print(categories)
//     return self.menuMap[value]!.count
//        }
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        if (indexPath.section == 0){
            let item = entreeItems[indexPath.row]
            cell.configureCell(item: item)
            //cell.set(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            cell.backgroundColor = UI_Colors.white
            //this line below is what creates the arrow in each tableview cell
            //cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            reloadInputViews()

            
        }
        if (indexPath.section == 1){
            let item = sidesItems[indexPath.row]
            cell.configureCell(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            cell.backgroundColor = UI_Colors.white
            //this line below is what creates the arrow in each tableview cell
            cell.selectionStyle = .none
            //cell.accessoryType = .disclosureIndicator
            reloadInputViews()

        }
        if (indexPath.section == 2){
            let item = anArray[indexPath.row]
            cell.configureCell(item: item)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = CG_Colors.lightPurple
            cell.layer.cornerRadius = 30.0
            cell.backgroundColor = UI_Colors.white
            //this line below is what creates the arrow in each tableview cell
            cell.selectionStyle = .none
            //cell.accessoryType = .disclosureIndicator
            reloadInputViews()

        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            let entreeSelected = entreeItems[indexPath.row]
            //print(entreeSelected.selectionChoice)
            self.entreeSelected = entreeSelected
            //shoppingCart.add(item: entreeSelected)
//            print(entreeSelected.toppings)
//            print(entreeSelected.options)
            self.segueToEntreeCustomizePage()
            //print(entreeSelected)
        }
        
        if indexPath.section == 1 {
            let sideSelected = sidesItems[indexPath.row]
           shoppingCart.add(item: sideSelected, quantity: 1)
            print(sideSelected.price)
            print(shoppingCart.totalCost)
        }
        
        if indexPath.section == 2 {
            let drinkSelected = drinksItems[indexPath.row]
            shoppingCart.add(item: drinkSelected, quantity: 1)
            print(shoppingCart.items)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
//        if cell.itemName.text != "" {
//            print(cell.itemName.text ?? "hello")
//        }
        
    }
//
        
    }

        
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
           return true
    }
        
        

