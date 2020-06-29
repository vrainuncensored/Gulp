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
    override func viewDidLoad() {
    super.viewDidLoad()
    //self.view.addBackground()
   // self.view.addLogo()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
        
        mainLogo.image = UIImage(named: "GulpLogo")
        
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = AppColors.darkPurple
        signupButton.setTitle("Sign Up", for: .normal)
        
        signinButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = AppColors.darkPurple
        signinButton.setTitle("Sign In", for: .normal)
           // UIColor(red: 204, green: 102, blue: 153, alpha: 1) as! CGColor
        
//    let button = UIButton(frame: CGRect(x: 100, y: 100, width: width/3, height: height/3))
//    button.setTitle("Continue as Guest", for: .normal)
//    button.showsTouchWhenHighlighted = true
//    button.layer.cornerRadius = 5
//    button.layer.borderWidth = 1
//    button.layer.borderColor = UIColor.systemPink.cgColor
//      button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//      self.view.addSubview(button)
//
//    let loginButton = UIButton(frame: CGRect(x: 100, y: 250, width: width/3, height: height/3))
//    loginButton.setTitle("Login in", for: .normal)
//    loginButton.showsTouchWhenHighlighted = true
//    loginButton.layer.cornerRadius = 5
//    loginButton.layer.borderWidth = 1
//    loginButton.layer.borderColor = UIColor.systemPink.cgColor
//      loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
//
//      self.view.addSubview(loginButton)
    }

    @objc func buttonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
    }
    @objc func loginAction(sender: UIButton!) {
        let loginFlow = UIStoryboard(name: "Login", bundle: nil)
        let controller = loginFlow.instantiateViewController(identifier: "loginPage")
        present(controller, animated: true, completion: nil)
      }
    
}


        
        
        
        
        
   
