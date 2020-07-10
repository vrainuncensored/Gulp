//
//  loginPage.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginPage: UIViewController {
    //Text Outlet
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    //Button Outlet
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
       
        forgotPassword.layer.cornerRadius = 5
        forgotPassword.layer.borderWidth = 1
        forgotPassword.layer.borderColor = UIColor.systemPink.cgColor
        forgotPassword.setTitle("Forgot Password", for: .normal)
        forgotPassword.setTitleColor(.black, for: .normal)
        forgotPassword.addTarget(self, action: #selector(forgotPasswordOption), for: .touchUpInside)
        
        
        signUp.layer.cornerRadius = 5
        signUp.layer.borderWidth = 1
        signUp.layer.borderColor = UIColor.systemPink.cgColor
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.black, for: .normal)
        signUp.addTarget(self, action: #selector(signupOption), for: .touchUpInside)

        
        
     
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "E-mail address"
//        userEmail.layer.cornerRadius = 5
//        userEmail.layer.borderWidth = 1
//        userEmail.layer.borderColor = UIColor.systemPink.cgColor
        
        
        userPassword.autocorrectionType = UITextAutocorrectionType.no
        userPassword.isSecureTextEntry = true
        userPassword.placeholder = "Password"
        userPassword.layer.cornerRadius = 5
        userPassword.layer.borderWidth = 1
        userPassword.layer.borderColor = UIColor.systemPink.cgColor
        
        
        
        
        userEmail.delegate = self
        userPassword.delegate = self
        
        
        
    
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
            Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] authResult, error in
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


extension LoginPage: UITextFieldDelegate {
    
}
