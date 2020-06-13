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
        let userName = UITextField()
        let userEmail = UITextField()
        let userPassowrd = UITextField()
        let userPassowrdConfirmation = UITextField()
        let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        userName.frame = CGRect(x:0, y:300, width:self.view.frame.width * 5/6 , height:self.view.frame.height * 1/10)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        userEmail.frame = CGRect(x:  0, y: 0, width: width * 5/6, height: height * 1/10)
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "Your email address"
        userEmail.layer.cornerRadius = 5
        userEmail.layer.borderWidth = 1
        userEmail.layer.borderColor = UIColor.systemPink.cgColor
        
        userPassowrd.frame = CGRect(x:  0, y: 100,  width: width * 5/6, height: height * 1/10)
        userPassowrd.placeholder = "Your account password!"
        userPassowrd.layer.cornerRadius = 5
        userPassowrd.layer.borderWidth = 1
        userPassowrd.layer.borderColor = UIColor.systemPink.cgColor
        
        userPassowrdConfirmation.frame = CGRect(x:  0, y: 200,  width: width * 5/6, height: height * 1/10)
        userPassowrdConfirmation.placeholder = "Password confirmation!"
        userPassowrdConfirmation.layer.cornerRadius = 5
        userPassowrdConfirmation.layer.borderWidth = 1
        userPassowrdConfirmation.layer.borderColor = UIColor.systemPink.cgColor

        userName.layer.cornerRadius = 5
        userName.layer.borderWidth = 1
        userName.layer.borderColor = UIColor.systemPink.cgColor
        userName.layer.borderColor = UIColor.systemPink.cgColor
        
        self.view.addSubview(userEmail)
        self.view.addSubview(userPassowrd)
        self.view.addSubview(userPassowrdConfirmation)
        self.view.addSubview(userName)

        userEmail.delegate = self
        userPassowrd.delegate = self
        userPassowrdConfirmation.delegate = self
        userName.delegate = self
        
        
        let signupButton = UIButton(frame: CGRect(x: 0, y: height * (6/8), width: width, height: height/8))
            signupButton.setTitle("Sign Up", for: .normal)
            signupButton.showsTouchWhenHighlighted = true
            signupButton.layer.cornerRadius = 5
            signupButton.layer.borderWidth = 1
            signupButton.layer.borderColor = UIColor.systemPink.cgColor
            signupButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
            self.view.addSubview(signupButton)
    }
    @objc func signUp(sender: UIButton!) {
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassowrdConfirmation.text!) { (result, error) in
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
