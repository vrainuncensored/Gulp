//
//  HomeBackground.swift
//  gulp
//
//  Created by Vrain Ahuja on 3/30/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
extension UIView {
func addBackground() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    imageViewBackground.image = UIImage(named: "324.jpg")

    // you can change the content mode:
    imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
    imageViewBackground.alpha = 0.15

    self.addSubview(imageViewBackground)
    self.sendSubviewToBack(imageViewBackground)
}
}

