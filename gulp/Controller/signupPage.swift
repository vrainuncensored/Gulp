//
//  signupPage.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class signupPage: UIViewController {
        let db = Firestore.firestore()
    
    //Text Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordConfirmation: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    //Button Outlets
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    //Label Outlets
    @IBOutlet weak var phoneDisclamer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup for the TextFields
        setupUserNameField()
        setupUserEmailField()
        setupUserPasswordField()
        setupUserPasswordConfirmationField()
        setupUserPhoneNumberField()
        
        //setup for Labels
        setupPhoneDisclamer()
        
        //setup for Buttons
        setupSignUpButton()
        setupSignInButton()
        
        //establishing delegates
        userEmail.delegate = self
        userPassword.delegate = self
        userPasswordConfirmation.delegate = self
        userName.delegate = self
        
    }
    func setupUserNameField() {
        userName.attributedPlaceholder = NSAttributedString(string:"Your full name" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
    func setupSignUpButton() {
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = CG_Colors.darkPurple
        signupButton.backgroundColor = UI_Colors.darkPurple
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.showsTouchWhenHighlighted = true
        signupButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
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
                    let dbUser = User.init(email: email!, id: authUser, stripeId: "", name: name!, phoneNumber: phoneNumber)
                    self.createFireStoreUser(user: dbUser)
                    self.segueToHome()
                }
            }
        }
    }
    
    func createFireStoreUser (user: User) {
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        let data = User.modelToData(user: user)
        newUserRef.setData(data)
    }
    @objc func signInAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "toSignin", sender: self)
    }
}




extension signupPage: UITextFieldDelegate {
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
}
