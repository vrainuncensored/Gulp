//
//  cartOrderStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/14/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

class ShoppingCart {
    private(set) var items: [CartItem] = []
}

extension ShoppingCart {
    var total: Double {
        get { return items.reduce(0.0) { value, item in
            value + item.subTotal
            }
        }
    }
}
