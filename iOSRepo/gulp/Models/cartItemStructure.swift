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
    var quantity : Int
    
    var subTotal : Double { get { return item.price * Double(quantity) }}
    
    init(item: MenuItem, quantity: Int){
        self.item = item
        self.quantity = quantity
    }
}


