//
//  ViewController.swift
//  gulp
//
//  Created by Vrain Ahuja on 3/26/20.
//  Copyright © 2020 Gulp. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
/*
 This method will be invoked after iOS app's view is loaded.
 */
    
    @IBOutlet weak var mainLogo: UIImageView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var slogan: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
        let test = UIImage(named: "GulpLogo12")
        slogan.textColor  = UI_Colors.darkPurple
        slogan.font = UIFont(name: "AvenirNext-Bold" , size: 40.0)
        slogan.textColor = UIColor.black

        mainLogo.image = test
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = CG_Colors.darkPurple
        signupButton.setTitle("Sign Up", for: .normal)
        
        signinButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = CG_Colors.darkPurple
        signinButton.setTitle("Sign In", for: .normal)
    
    }

    @objc func buttonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
    }
    @objc func loginAction(sender: UIButton!) {
        let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
        let controller = loginFlow.instantiateViewController(identifier: "loginPage")
        present(controller, animated: true, completion: nil)
      }
    @objc func signUpAction(sender: UIButton!) {
          let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
          let controller = loginFlow.instantiateViewController(identifier: "signupPage")
          present(controller, animated: true, completion: nil)
        }
    
}


        
        
        
        
        
   
