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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configName()
        
      
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        userEmail.frame = CGRect(x:  0, y: 0, width: width * 5/6, height: height * 1/10)
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "Your email address"
        userEmail.layer.cornerRadius = 5
        userEmail.layer.borderWidth = 1
        userEmail.layer.borderColor = UIColor.systemPink.cgColor
        
        userPassword.placeholder = "Your account password!"
      
        
        userPasswordConfirmation.frame = CGRect(x:  0, y: 200,  width: width * 5/6, height: height * 1/10)
        userPasswordConfirmation.placeholder = "Password confirmation!"
        userPasswordConfirmation.layer.cornerRadius = 5
        userPasswordConfirmation.layer.borderWidth = 1
        userPasswordConfirmation.layer.borderColor = UIColor.systemPink.cgColor

//        userName.layer.cornerRadius = 5
//        userName.layer.borderWidth = 1
//        userName.layer.borderColor = UIColor.systemPink.cgColor
//        userName.layer.borderColor = UIColor.systemPink.cgColor
        
     

        userEmail.delegate = self
        userPassword.delegate = self
        userPasswordConfirmation.delegate = self
        userName.delegate = self
        
        
       
            signupButton.setTitle("Sign Up", for: .normal)
            signupButton.showsTouchWhenHighlighted = true
            signupButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    func configName() {
        //name.placeholder = "Full Name"
    }
    @objc func signUp(sender: UIButton!) {
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPasswordConfirmation.text!) { (result, error) in
            if let error = error {
                debugPrint(error)
            } else {
            let authUser = result!.user.uid
            let email = self.userEmail.text
            let name = self.userName.text
            let dbUser = User.init(email: email!, id: authUser, stripeId: "", name: name!)
            self.createFireStoreUser(user: dbUser)
            }
        }
    }
    func createFireStoreUser (user: User) {
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        let data = User.modelToData(user: user)
        newUserRef.setData(data)
    }
    
}




extension signupPage: UITextFieldDelegate {
    
}
