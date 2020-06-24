//
//  checkoutToStripe.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/23/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
extension UIView {
func addCheckoutButton() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let image = UIImage(named: "logo.png")
    let label = UILabel()
    label.text = "Confirm Checkout"

    let imageViewBackground = UIButton(frame: CGRect(x:  0, y: 0, width: width/4, height: height/4))
//    imageViewBackground.setImage(image, for: .normal)
    // you can change the content mode:
    imageViewBackground.setTitle("Confirm Checkout", for: .normal)
    imageViewBackground.setTitleColor(UIColor.blue, for: .normal)
    imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
    imageViewBackground.alpha = 1

    self.addSubview(imageViewBackground)
    
    imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
    imageViewBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    imageViewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    imageViewBackground.heightAnchor.constraint(equalToConstant: 25).isActive = true
    imageViewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

    }
}
