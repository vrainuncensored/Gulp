//
//  UIView+EXT.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/8/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

extension UIView{
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true

    }
}
//this extension balls the entire content to the walls of the device

