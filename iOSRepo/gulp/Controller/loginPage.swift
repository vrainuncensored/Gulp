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
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup for the buttons
        setupSignInButton()
        setupSignUpButton()
        //setup for the TextFields
        setupUserEmailTextField()
        setupUserPasswordField()
        //establishing delegates
        userEmail.delegate = self
        userPassword.delegate = self
        }
    
    
    func setupSignInButton() {
        signIn.setTitle("Sign In", for: .normal)
        signIn.showsTouchWhenHighlighted = true
        signIn.layer.cornerRadius = 5
        signIn.layer.borderWidth = 1
        signIn.layer.borderColor = CG_Colors.darkPurple
        signIn.backgroundColor = UI_Colors.darkPurple
        signIn.addTarget(self, action: #selector(signinOption), for: .touchUpInside)
    }
    func setupSignUpButton() {
        signUp.setTitle("Don't have an account? Create one.", for: .normal)
        signUp.setTitleColor(.black, for: .normal)
        signUp.addTarget(self, action: #selector(signupOption), for: .touchUpInside)
    }
    func setupUserEmailTextField() {
        userEmail.borderStyle = UITextField.BorderStyle.none
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.borderStyle = UITextField.BorderStyle.none
        userEmail.attributedPlaceholder = NSAttributedString(string:"E-mail address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userEmail.adjustsFontSizeToFitWidth = true
    
    }
    func setupUserPasswordField() {
        userPassword.autocorrectionType = UITextAutocorrectionType.no
        userPassword.isSecureTextEntry = true
        userPassword.attributedPlaceholder = NSAttributedString(string:"Password ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPassword.borderStyle = UITextField.BorderStyle.none
        userPassword.adjustsFontSizeToFitWidth = true
    }
    @objc func signupOption(sender: UIButton!) {
        self.performSegue(withIdentifier: "toSignup", sender: self)
    }
    @objc func signinOption(sender: UIButton!) {
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            self?.segueToHome()
            
        }
        
    }
    @objc func forgotPasswordOption(sender: UIButton!) {
        Auth.auth().sendPasswordReset(withEmail: userEmail.text!) { error in
            self.simpleAlert(title: "Password Reset" , msg: "We have a password reset link to your email! Please take a look")
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
