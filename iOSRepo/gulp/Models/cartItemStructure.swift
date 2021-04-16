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
    var additionalComments : String?
    var options : [SelectionOption]?
    
    var subTotal : Double { get { return item.price * Double(quantity) }}
    
    var SubTot : Double {
        if options?.count == 0 {
            return item.price * Double(quantity)
        } else {
            var optionTotal = 0.0
            for option in options! {
               optionTotal = optionTotal + option.price
            }
            return (item.price + optionTotal) * Double(quantity)
        }
        
    }
    
    init(item: MenuItem, quantity: Int, additionalComments: String, options: [SelectionOption]){
        self.item = item
        self.quantity = quantity
        self.additionalComments = additionalComments
        self.options = options
    }
    static func modelToData(cartItem: CartItem) -> [String: Any] {
        let data: [String: Any] = [
            "item": cartItem.item.name,
            "quantity" : cartItem.quantity,
            "additionalComments" : cartItem.additionalComments ?? "",
//            "options" : cartItem.options
        ]
        return data
    }
}


extension CartItem {
// MARK: Equatable
static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
    return lhs == rhs
}
}
