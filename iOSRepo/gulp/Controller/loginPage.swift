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
import FBSDKLoginKit

class LoginPage: UIViewController {
    //Text Outlet
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    
    //Button Outlet
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    //Label Outlet
    @IBOutlet weak var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup for the buttons
        setupSignInButton()
        setupSignUpButton()
        //settupFacebookButton()
        //setup for the TextFields
        setupUserEmailTextField()
        setupUserPasswordField()
        //establishing delegates
        userEmail.delegate = self
        userPassword.delegate = self
        
        self.view.backgroundColor = UI_Colors.white
        }
    
    
    func setupSignInButton() {
        signIn.setTitle("Sign In", for: .normal)
        signIn.showsTouchWhenHighlighted = true
        signIn.layer.cornerRadius = 5
        signIn.layer.borderWidth = 1
        signIn.layer.borderColor = CG_Colors.red
        signIn.backgroundColor = UI_Colors.red
        signIn.addTarget(self, action: #selector(signinOption), for: .touchUpInside)
        signIn.setTitleColor(.white, for: .normal)
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
            userservice.getUser()
            print(userservice.user.stripeId)
            let user = Auth.auth().currentUser
            print( user?.uid)
            //print(strongSelf)
            if let authResult = authResult{
             self?.segueToHome()
            } else {
                self?.simpleAlert(title: "Incorrect Login", msg: "The login informantion that you entered in incorrect. Please try again")
            }
        }
        
    }
    func settupFacebookButton() {
        let facebookButton =  FBLoginButton()
        facebookButton.delegate = self
        facebookButton.permissions = ["public_profile", "email"]
        view.addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        facebookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        facebookButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 15).isActive = true
        view.addSubview(facebookButton)
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

extension LoginPage: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
          }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print("error")
            }
            
//            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
         
    }
}
