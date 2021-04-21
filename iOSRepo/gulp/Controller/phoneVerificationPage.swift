//
//  phoneVerificationPage.swift
//  gulp
//
//  Created by vrain ahuja on 4/20/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class phoneVerificationPage: UIViewController {
    
    //Label
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Text Fields
    @IBOutlet weak var phoneNumberField: UITextField!
    
    //Button
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpButton()
        setupUserPhoneNumberField()
        phoneNumberField.delegate = self

        // Do any additional setup after loading the view.
    }
    func setupSignUpButton() {
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = CG_Colors.red
        signupButton.backgroundColor = UI_Colors.red
        signupButton.setTitle("Let's get started!", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.showsTouchWhenHighlighted = true
        signupButton.addTarget(self, action: #selector(movingOn), for: .touchUpInside)
    }
    func setupUserPhoneNumberField() {
        phoneNumberField.attributedPlaceholder = NSAttributedString(string:"Your phone number (required)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        phoneNumberField.borderStyle = UITextField.BorderStyle.none
        }
    @objc func movingOn(){
        print(phoneNumberField.text)
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
extension phoneVerificationPage: UITextFieldDelegate {
    func convertPhoneNumber(userPhoneNumber: UITextField) -> String {
        let acceptedPhoneNumber = phoneNumberField.text!
        let phoneNumberForDB = "+1" + "\(acceptedPhoneNumber)"
        return(phoneNumberForDB)
    }
    func testForVaildPhoneNumber() -> Bool  {
        if phoneNumberField.text?.count == 0 || phoneNumberField.text!.count > 10 ||  phoneNumberField.text!.count < 10 {
           simpleAlert(title: "Invalid Phone number", msg: "Your phone number has been incorrectly inputted. Make sure it is the full 10 digits")
            return (false)
        }
        return (true)
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//         // Try to find next responder
//         if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//         } else {
//            // Not found, so remove keyboard.
//            textField.resignFirstResponder()
//            return false
//         }
//         // Do not add a line break
//         return false
//      }
}
