//
//  signIn.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/3/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class loginPage: UIViewController {
        let forgotPassword = UIButton()
        let userEmail = UITextField()
        let userPassowrd = UITextField()
        let signIn = UIButton()
        let signUp = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        forgotPassword.frame = CGRect(x:  0, y: 200, width: width * 5/6, height: height * 1/10)
        forgotPassword.layer.cornerRadius = 5
        forgotPassword.layer.borderWidth = 1
        forgotPassword.layer.borderColor = UIColor.systemPink.cgColor
        forgotPassword.setTitle("Forgot Password", for: .normal)
        forgotPassword.setTitleColor(.black, for: .normal)
        forgotPassword.addTarget(self, action: #selector(forgotPasswordOption), for: .touchUpInside)
        
        signUp.frame = CGRect(x:  0, y: 300, width: width * 5/6, height: height * 1/10)
        signUp.layer.cornerRadius = 5
        signUp.layer.borderWidth = 1
        signUp.layer.borderColor = UIColor.systemPink.cgColor
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.black, for: .normal)
        signUp.addTarget(self, action: #selector(signupOption), for: .touchUpInside)

        
        
        userEmail.frame = CGRect(x:  0, y: 0, width: width * 5/6, height: height * 1/10)
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "Your email address"
        userEmail.layer.cornerRadius = 5
        userEmail.layer.borderWidth = 1
        userEmail.layer.borderColor = UIColor.systemPink.cgColor
        userPassowrd.frame = CGRect(x:  0, y: 100,  width: width * 5/6, height: height * 1/10)
        userPassowrd.autocorrectionType = UITextAutocorrectionType.no
        userPassowrd.isSecureTextEntry = true
        userPassowrd.placeholder = "Your account password!"
        userPassowrd.layer.cornerRadius = 5
        userPassowrd.layer.borderWidth = 1
        userPassowrd.layer.borderColor = UIColor.systemPink.cgColor
        
        self.view.addSubview(userEmail)
        self.view.addSubview(userPassowrd)
        self.view.addSubview(forgotPassword)
        self.view.addSubview(signIn)
        self.view.addSubview(signUp)
        
        userEmail.delegate = self
        userPassowrd.delegate = self
        
        
        
        signIn.frame = CGRect(x: 0, y: height * (6/8), width: width, height: height/8)
        signIn.setTitle("Sign In", for: .normal)
        signIn.showsTouchWhenHighlighted = true
        signIn.layer.cornerRadius = 5
        signIn.layer.borderWidth = 1
        signIn.layer.borderColor = UIColor.systemPink.cgColor
        signIn.addTarget(self, action: #selector(signinOption), for: .touchUpInside)
        self.view.addSubview(signIn)
        }
         @objc func signupOption(sender: UIButton!) {
               self.performSegue(withIdentifier: "toSignup", sender: self)
           }
        @objc func signinOption(sender: UIButton!) {
            let mainFlow = UIStoryboard(name: "Main", bundle: nil)
            let controller = mainFlow.instantiateViewController(identifier: "homePage")
            Auth.auth().signIn(withEmail: userEmail.text!, password: userPassowrd.text!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              print( "user signed in")
            self!.present(controller, animated: true, completion: nil)
                
            }
        
              }
    @objc func forgotPasswordOption(sender: UIButton!) {
        Auth.auth().sendPasswordReset(withEmail: userEmail.text!) { error in
      // ...
    }
        // Do any additional setup after loading the view.
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


extension loginPage: UITextFieldDelegate {
  
}

