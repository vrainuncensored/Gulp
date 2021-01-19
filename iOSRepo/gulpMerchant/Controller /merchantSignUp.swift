//
//  merchantSignUp.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/4/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SafariServices


class merchantSignupPage: UIViewController {
   //Text Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordConfirmation: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    //Button Outlets
    @IBOutlet weak var addBankAccount: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    //Label Outlets
    @IBOutlet weak var phoneDisclamer: UILabel!
    
   let db = Firestore.firestore()

   let state: String = generateRandomNumber()// generate a unique value for this
   let clientID: String = "ca_HDc2f2N9XftwO50jLFIp0uDsSx1CZqOS"// the client ID found in your platform settings



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userName.tag = 0
        userEmail.tag = 1
        userPassword.tag = 2
        userPasswordConfirmation.tag = 3
        userPhoneNumber.tag = 4
        
        
        
        //setup for the TextFields
        setupUserNameField()
        setupUserEmailField()
        setupUserPasswordField()
        setupUserPasswordConfirmationField()
        setupUserPhoneNumberField()
        
        //setup for Labels
        setupPhoneDisclamer()
        
        //setup for Buttons
        setupAddBankButton()
        setupSignInButton()
        
        //establishing delegates
        userEmail.delegate = self
        userPassword.delegate = self
        userPasswordConfirmation.delegate = self
        userName.delegate = self
        userPhoneNumber.delegate = self
        
    }
    func setupUserNameField() {
        userName.attributedPlaceholder = NSAttributedString(string:"Trucks Name" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userName.borderStyle = UITextField.BorderStyle.none
    }
    func setupUserEmailField() {
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "Your email address"
        userEmail.attributedPlaceholder = NSAttributedString(string:"Your E-mail address (required)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userEmail.borderStyle = UITextField.BorderStyle.none
    }
    func setupUserPasswordField() {
        userPassword.placeholder = "Your account password!"
        userPassword.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPassword.borderStyle = UITextField.BorderStyle.none
        userPassword.isSecureTextEntry = true
    }
    func setupUserPasswordConfirmationField() {
        userPasswordConfirmation.placeholder = "Password confirmation!"
        userPasswordConfirmation.attributedPlaceholder = NSAttributedString(string:"Confirm your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPasswordConfirmation.borderStyle = UITextField.BorderStyle.none
        userPasswordConfirmation.isSecureTextEntry = true
        
    }
    func setupUserPhoneNumberField() {
        userPhoneNumber.attributedPlaceholder = NSAttributedString(string:"Your phone number (required)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPhoneNumber.borderStyle = UITextField.BorderStyle.none
    }
    func setupPhoneDisclamer() {
        phoneDisclamer.adjustsFontSizeToFitWidth = true
    }
    func setupAddBankButton() {
        addBankAccount.layer.cornerRadius = 5
        addBankAccount.layer.borderWidth = 1
        addBankAccount.layer.borderColor = CG_Colors.red
        addBankAccount.backgroundColor = UI_Colors.red
        addBankAccount.setTitle("Sign Up", for: .normal)
        addBankAccount.showsTouchWhenHighlighted = true
        addBankAccount.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        addBankAccount.setTitleColor(.white, for: .normal)
    }
    func setupSignInButton() {
        signinButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
    }
    
    @objc func signUp(sender: UIButton!) {
        if testForVaildPhoneNumber() == true{
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPasswordConfirmation.text!) { (result, error) in
                if let errors = error {
                    if let errorcode = AuthErrorCode(rawValue: error!._code) {
                        switch errorcode {
                        case .invalidEmail:
                            self.simpleAlert(title: "Invalid email", msg: "Please be sure your formatting is correct")
                            print("invalid email")
                        case .emailAlreadyInUse:
                            self.simpleAlert(title: "Incorrect Email", msg: "This email is already in use!")
                        default:
                            print("Create User Error: \(error!)")
                        }
                    }
          
                } else {
                    let authUser = result!.user.uid
                    let email = self.userEmail.text
                    let name = self.userName.text
                    let phoneNumber = self.convertPhoneNumber(userPhoneNumber: self.userPhoneNumber)
                    let defaultLocation = GeoPoint(latitude: 0.0, longitude: 0.0)
                    let dbUser = Merchant.init(email: email!, id: authUser, stripeId: "", name: name!, locationCoordinates: defaultLocation , phoneNumber: phoneNumber)
                    self.createFireStoreUser(merchant: dbUser)
                    self.segueToOrders()
                }
            }
        }
    }
    
    func createFireStoreUser (merchant: Merchant) {
        let newUserRef = Firestore.firestore().collection("merchant").document(merchant.id)
        let data = Merchant.modelToData(merchant: merchant)
        newUserRef.setData(data)
    }
    @objc func signInAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "segueToSignIn", sender: self)
    }
    @objc func didSelectConnectWithStripe() {
          // set the redirect_uri to a deep link back into your app to automatically
          // detect when the user has completed the onboarding flow
          let redirect = "https://www.example.com/connect-onboard-redirect"

          // Construct authorization URL
          guard let authorizationURL = URL(string: "https://connect.stripe.com/express/oauth/authorize?client_id=\(clientID)&state=\(state)&redirect_uri=\(redirect)") else {
              return
          }

          let safariViewController = SFSafariViewController(url: authorizationURL)
          safariViewController.delegate = self

          present(safariViewController, animated: true, completion: nil)
      }

}




extension merchantSignupPage: UITextFieldDelegate {
    func convertPhoneNumber(userPhoneNumber: UITextField) -> String {
        let acceptedPhoneNumber = userPhoneNumber.text!
        let phoneNumberForDB = "+1" + "\(acceptedPhoneNumber)"
        return(phoneNumberForDB)
    }
    func testForVaildPhoneNumber() -> Bool  {
        if userPhoneNumber.text?.count == 0 || userPhoneNumber.text!.count > 10 ||  userPhoneNumber.text!.count < 10 {
           simpleAlert(title: "Invalid Phone number", msg: "Your phone number has been incorrectly inputted. Make sure it is the full 10 digits")
            return (false)
        }
        return (true)
    }
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

extension merchantSignupPage: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}
