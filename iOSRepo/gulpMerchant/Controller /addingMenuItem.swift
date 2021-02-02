//
//  addingMenuItem.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/6/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class addingMenuItem: UIViewController {
    //UITextLabel Outlets
    @IBOutlet weak var itemLabel: UILabel!
    
   //UITextField Outlets
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    //UIButton Outlets
    @IBOutlet weak var customizeItem: UIButton!
    @IBOutlet weak var addItem: UIButton!
    
    //UIPickerView Outlet
    
    @IBOutlet weak var itemCategory: UIPickerView!
    
    
    let categoryOptions = ["entrees", "sides", "drinks"]
    let itemCategoryName = UILabel()
    var id = ""
    
    override func viewDidLoad() {
        //The line below make the nav bar much lager. It is conflicting with the UITextFields, I will have to come back to this once the textfield has been organized in one item
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
        viewWillLayoutSubviews()
        itemCategory.dataSource = self
        itemCategory.delegate = self
        itemCategory.setValue(UIColor.black, forKeyPath: "textColor")

        

        
        
        let user = Auth.auth().currentUser
        if let user = user {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        let uid = user.uid
        let email = user.email
        if Auth.auth().currentUser != nil {
            print( uid)
            print ( email)
            
        } else {
          print("there is NOT user")
        }
        }
        id = (user?.uid)!
        
        //let itemCategoryText = itemCategory.text
        let itemNameText = itemName.text
        let itemPriceText = itemPrice.text
        
        
        
        
        
        
        setupAddItemButton()
        //self.view.addBackground()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        
        
        
       
        super.viewDidLoad()
        
        setupItemNameField()
        setupItemPriceField()
        //setupItemCategoryField()
        setupCustomizeItemButton()
        
        
        super.viewDidLoad()
        
        itemCategory.delegate = self
        itemName.delegate = self
        itemName.delegate = self
        
        itemName.tag = 0
        itemPrice.tag = 2
        
        itemName.keyboardType = UIKeyboardType.decimalPad
        self.addDoneButtonOnKeyboard()

        
       
        
      
        
        
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
               if(segue.identifier == "segueToCustomizeEntreesSettings"){
                       let displayVC = segue.destination as! EntreeCustomizeOptionsVC
                       displayVC.truckIdforFB = id
               }
           }
    
    func agreeToTerms() {
        // Create the action buttons for the alert.
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { (action) in
                                            // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Missing Information",
                                      message: "Uhh Ohh, seems your customers don't have all the required information! Please fill out all the fields",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true) {
            // The alert was presented
        }
    }

    
    @objc func createMenuItem () {
        if itemCategoryName.text == "" || itemPrice.text == "" || itemName.text == ""  {
             agreeToTerms()
                }
        else{
           let dbItem = MenuItem.init(price: itemPrice.text!, itemCategory: itemCategoryName.text!, name: itemName.text!)
           self.createFireStoreItem(item: dbItem)
        }
    }
    func itemAdded() {
      self.performSegue(withIdentifier: "itemAdded", sender: self)
    }
    func setupAddItemButton() {
        addItem.layer.cornerRadius = 5
        addItem.layer.borderWidth = 1
        addItem.layer.borderColor = CG_Colors.darkPurple
        addItem.backgroundColor = UI_Colors.darkPurple
        addItem.setTitle("Add Item", for: .normal)
        addItem.showsTouchWhenHighlighted = true
        addItem.addTarget(self, action: #selector(createMenuItem), for: .touchUpInside)
    }
    func setupItemNameField() {
        itemName.layer.cornerRadius = 5
        itemName.layer.borderWidth = 1
        itemName.layer.borderColor = CG_Colors.lightPurple
        itemName.textColor = UIColor.black
        itemName.autocapitalizationType = UITextAutocapitalizationType.none
        itemName.attributedPlaceholder = NSAttributedString(string: "Menu Item Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        itemName.textColor = UI_Colors.black
    }
    func setupItemPriceField() {
           itemPrice.layer.cornerRadius = 5
           itemPrice.layer.borderWidth = 1
           itemPrice.layer.borderColor = CG_Colors.lightPurple
           itemPrice.textColor = UIColor.black
           itemPrice.autocapitalizationType = UITextAutocapitalizationType.none
        itemPrice.attributedPlaceholder = NSAttributedString(string: "Item Price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        itemPrice.textColor = UI_Colors.black
       }
//    func setupItemCategoryField() {
//              itemCategory.layer.cornerRadius = 5
//              itemCategory.layer.borderWidth = 1
//              itemCategory.layer.borderColor = CG_Colors.lightPurple
//              itemCategory.textColor = UIColor.black
//              itemCategory.autocapitalizationType = UITextAutocapitalizationType.none
//              itemCategory.placeholder = "Category"
//          }
    func setupCustomizeItemButton() {
        customizeItem.addTarget(self, action: Selector(("segueToEntreeCustomizingPage")), for: UIControl.Event.touchUpInside)
    }
    func createFireStoreItem (item : MenuItem) {
        let newItemRef = Firestore.firestore().collection("merchant").document(self.id).collection("menu").document(item.name)
        let data = MenuItem.modelToData(menuItem: item)
        newItemRef.setData(data){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.itemAdded()
            }
        }
    }
    @objc func segueToEntreeCustomizingPage(){
                  self.performSegue(withIdentifier: "segueToCustomizeEntreesSettings", sender: self)
       }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
      
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: Selector(("doneButtonAction")))
      
      var items = [UIBarButtonItem]()
      items.append(flexSpace)
      items.append(done)
      
      doneToolbar.items = items
      doneToolbar.sizeToFit()
      
      self.itemName.inputAccessoryView = doneToolbar
      
    }
     @objc func doneButtonAction()
    {
      self.itemName.resignFirstResponder()
    }
}

extension addingMenuItem: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // Try to find next responder
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
    
         }
         // Do not add a line break
         return false
      }
    
}

extension addingMenuItem: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryOptions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         itemCategoryName.text = categoryOptions[row]
    }
}
