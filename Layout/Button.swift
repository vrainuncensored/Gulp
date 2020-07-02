//
//  Button.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/28/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import UIKit

class RoundedShadowView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.purple as! CGColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        
    }
}

class RoundedButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

//func setupHomeButtons(name: String ) {
//    "\(name)".layer.borderWidth = 2
//     "\(name)".layer.borderColor = AppColors.darkPurple
//}
