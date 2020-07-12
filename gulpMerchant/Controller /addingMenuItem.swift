//
//  addingMenuItem.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/6/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase

class addingMenuItem: UIViewController {
    let itemCategory = UITextField()
    let itemName = UITextField()
    let itemPrice = UITextField()
    let createItemButton = UIButton()
    let setEntreeOptions = UIButton()
    var id = ""
    
    override func viewDidLoad() {
        //The line below make the nav bar much lager. It is conflicting with the UITextFields, I will have to come back to this once the textfield has been organized in one item
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
        viewWillLayoutSubviews()
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
        
        let itemCategoryText = itemCategory.text
        let itemNameText = itemName.text
        let itemPriceText = itemPrice.text
        
        
        
        
        
        
        self.navigationItem.title = "New Menu Item!"
        //self.view.addBackground()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        
        
        
        itemCategory.textColor = UIColor.red
        itemCategory.frame = CGRect(x:  0, y: 100, width: width * 5/6, height: height * 1/10)
        itemCategory.autocapitalizationType = UITextAutocapitalizationType.none
        itemCategory.placeholder = "Item Category"
        itemCategory.layer.cornerRadius = 5
        itemCategory.layer.borderWidth = 1
        self.view.addSubview(itemCategory)
        super.viewDidLoad()
        
        
        itemName.textColor = UIColor.red
        itemName.frame = CGRect(x:  0, y: 300, width: width * 5/6, height: height * 1/10)
        itemName.autocapitalizationType = UITextAutocapitalizationType.none
        itemName.placeholder = "Menu Item Name"
        itemName.layer.cornerRadius = 5
        itemName.layer.borderWidth = 1
        self.view.addSubview(itemName)
        super.viewDidLoad()
        
        itemPrice.textColor = UIColor.red
        itemPrice.frame = CGRect(x:  0, y:500, width: width * 5/6, height: height * 1/10)
        itemPrice.autocapitalizationType = UITextAutocapitalizationType.none
        itemPrice.placeholder = "Menu Item Price"
        itemPrice.layer.cornerRadius = 5
        itemPrice.layer.borderWidth = 1
        self.view.addSubview(itemPrice)
        super.viewDidLoad()
        
        itemCategory.delegate = self
        itemName.delegate = self
        itemPrice.delegate = self
        
        itemCategory.tag = 0
        itemName.tag = 1
        itemPrice.tag = 2
        
        itemPrice.keyboardType = UIKeyboardType.decimalPad
        self.addDoneButtonOnKeyboard()

        
        let button = UIButton()
        button.setTitle("Return", for: UIControl.State())
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.frame = CGRect(x: 0, y: 400, width: 106, height: 53)
        button.adjustsImageWhenHighlighted = false
        self.view.addSubview(button)
        button.addTarget(self, action: Selector(("createMenuItem")), for: UIControl.Event.touchUpInside)

        
        let customizeButton = UIButton()
               customizeButton.setTitle("Customize Settings", for: UIControl.State())
               customizeButton.setTitleColor(UIColor.black, for: UIControl.State())
               customizeButton.frame = CGRect(x: 300, y: 100, width: 106, height: 53)
               customizeButton.adjustsImageWhenHighlighted = false
               self.view.addSubview(customizeButton)
               customizeButton.addTarget(self, action: Selector(("segueToEntreeCustomizingPage")), for: UIControl.Event.touchUpInside)
        
        
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
        if itemCategory.text == "" || itemPrice.text == "" || itemName.text == ""  {
             agreeToTerms()
                }
        else{
           let dbItem = MenuItem.init(price: itemPrice.text!, itemCategory: itemCategory.text!, name: itemName.text!)
           self.createFireStoreItem(item: dbItem)
        }
    }
    func itemAdded() {
      self.performSegue(withIdentifier: "itemAdded", sender: self)
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
      
      self.itemPrice.inputAccessoryView = doneToolbar
      
    }
     @objc func doneButtonAction()
    {
      self.itemPrice.resignFirstResponder()
    }
}

extension addingMenuItem: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // Try to find next responder
         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
    
         }
         // Do not add a line break
         return false
      }
    
}
