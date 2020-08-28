//
//  cartItemStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/14/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

class CartItem {
    
    var item : MenuItem
    var quantity : Int = 1
    
    var subTotal : Double { get { return item.price * Double(quantity) }}
    
    init(item: MenuItem){
        self.item = item
    }
}


