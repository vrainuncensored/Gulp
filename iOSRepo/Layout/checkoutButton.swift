//
//  checkoutButton.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/11/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class CheckoutButton: UIViewController {
/*
 This method will be invoked after iOS app's view is loaded.
 */
override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addBackground()
    //self.view.addLogo()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let button = UIButton(frame: CGRect(x: 0, y: height * (7/8), width: width, height: height/8))
    button.setTitle("Total", for: .normal)
    button.showsTouchWhenHighlighted = true
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemPink.cgColor
      button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

      self.view.addSubview(button)
    }
    let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
    @objc func buttonAction(sender: UIButton!) {
      self.present(alert, animated: true, completion: nil)
    }
    
}


        
