//
//  mainLogo.swift
//  gulp
//
//  Created by Vrain Ahuja on 3/31/20.
//  Copyright © 2020 Gulp. All rights reserved.
//



import UIKit
extension UIView {
func addLogo() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let imageViewBackground = UIImageView(frame: CGRect(x:  0, y: 0, width: width/4, height: height/4))
    imageViewBackground.image = UIImage(named: "GulpLogo .pdf")

    // you can change the content mode:
    imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
    imageViewBackground.alpha = 1

    self.addSubview(imageViewBackground)
    }
}
