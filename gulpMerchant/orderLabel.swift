//
//  orderLabel.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/2/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
extension UIView {
    func addLabel(text: String) {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height/2))
    label.text = text
    

    // you can change the content mode:
    label.contentMode = UIView.ContentMode.scaleAspectFill

    
    



    self.addSubview(label)
    self.sendSubviewToBack(label)
}
}


