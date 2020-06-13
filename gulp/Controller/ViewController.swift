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
override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addBackground()
    self.view.addLogo()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: width/3, height: height/3))
    button.setTitle("Continue as Guest", for: .normal)
    button.showsTouchWhenHighlighted = true
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemPink.cgColor
      button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

      self.view.addSubview(button)
    
    let loginButton = UIButton(frame: CGRect(x: 100, y: 250, width: width/3, height: height/3))
    loginButton.setTitle("Login in", for: .normal)
    loginButton.showsTouchWhenHighlighted = true
    loginButton.layer.cornerRadius = 5
    loginButton.layer.borderWidth = 1
    loginButton.layer.borderColor = UIColor.systemPink.cgColor
      loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

      self.view.addSubview(loginButton)
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


        
        
        
        
        
   
