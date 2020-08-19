//
//  EntreeCustomizeOptionsVC.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase

class EntreeCustomizeOptionsVC: UIViewController {
    //UITextField Outlet
    @IBOutlet weak var addOnName: UITextField!
    @IBOutlet weak var addOnPrice: UITextField!
    
    
    //UIButton Outlet
    @IBOutlet weak var addOn: UIButton!
    
    //UIPickerView Outlet
    
    @IBOutlet weak var categorySelection: UIPickerView!
    
    let categoryOptions = ["Protein Options", "Add ons"]
    let pickerView = UIPickerView()
    let customizeButton = UILabel()
    let itemName = UITextField()
    let itemPrice = UITextField()
    var truckIdforFB = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width
             let height = UIScreen.main.bounds.size.height
//                    customizeButton.frame = CGRect(x: 300, y: 100, width: 106, height: 53)
//                    self.view.addSubview(customizeButton)
//        customizeButton.text = "choose category"
//        self.view.addSubview(pickerView)
        categorySelection.dataSource = self
        categorySelection.delegate = self
//        itemName.textColor = UIColor.red
//               itemName.frame = CGRect(x:  0, y:250, width: width * 5/6, height: height * 1/10)
//               itemName.autocapitalizationType = UITextAutocapitalizationType.none
//               itemName.placeholder = "Menu Item Name"
//               itemName.layer.cornerRadius = 5
//               itemName.layer.borderWidth = 1
//               self.view.addSubview(itemName)
   setupAddOnName()
   setupAddOnNamePrice()
        setupDoneCustomizingButton()
               
               itemName.delegate = self
               itemPrice.delegate = self
               
               itemName.tag = 1
               itemPrice.tag = 2
               
               itemPrice.keyboardType = UIKeyboardType.decimalPad
               self.addDoneButtonOnKeyboard()
        
//        let button = UIButton()
//         button.setTitle("Return", for: UIControl.State())
//         button.setTitleColor(UIColor.black, for: UIControl.State())
//         button.frame = CGRect(x: 0, y: 400, width: 106, height: 53)
//         button.adjustsImageWhenHighlighted = false
//         self.view.addSubview(button)
//         button.addTarget(self, action: Selector(("createMenuItem")), for: UIControl.Event.touchUpInside)

        
       
        // Do any additional setup after loading the view.
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
    func setupAddOnName() {
        addOnName.textColor = UIColor.red
        addOnName.autocapitalizationType = UITextAutocapitalizationType.none
        addOnName.placeholder = "Add On Name"
        addOnName.layer.cornerRadius = 5
        addOnName.layer.borderWidth = 1
        addOnName.layer.borderColor = CG_Colors.lightPurple
    }
    func setupAddOnNamePrice() {
        //addOnPrice.textColor = UIColor.black
        addOnPrice.autocapitalizationType = UITextAutocapitalizationType.none
        addOnPrice.placeholder = "Menu Item Price"
        addOnPrice.layer.cornerRadius = 5
        addOnPrice.layer.borderWidth = 1
        addOnPrice.layer.borderColor = CG_Colors.lightPurple
        addOnPrice.text = "$0.00"
    }
    func setupCategoryName() {
    
    }
    func setupDoneCustomizingButton() {
        addOn.layer.cornerRadius = 5
        addOn.layer.borderWidth = 1
        addOn.layer.borderColor = CG_Colors.darkPurple
        addOn.backgroundColor = UI_Colors.darkPurple
        addOn.setTitle("Customization Complete", for: .normal)
        addOn.showsTouchWhenHighlighted = true
    }
    
    @objc func createMenuItem () {
          if customizeButton.text == "" || itemPrice.text == "" || itemName.text == ""  {
               agreeToTerms()
                  }
          else{
             let dbItem = MenuItem.init(price: itemPrice.text!, itemCategory: customizeButton.text!, name: itemName.text!)
             self.createFireStoreItem(item: dbItem)
          }
      }
    
    func itemAdded() {
      self.performSegue(withIdentifier: "segueToMenuItems", sender: self)
    }
    func createFireStoreItem (item : MenuItem) {
        let newItemRef = Firestore.firestore().collection("merchant").document(self.truckIdforFB).collection("menuAddOns").document(item.name)
        let data = MenuItem.modelToData(menuItem: item)
        newItemRef.setData(data){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
               self.itemAdded()
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
extension EntreeCustomizeOptionsVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
         customizeButton.text = categoryOptions[row]
    }
}

extension EntreeCustomizeOptionsVC: UITextFieldDelegate{
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
