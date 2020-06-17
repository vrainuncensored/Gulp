//
//  cartOrderStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/14/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

let shoppingCart = _ShoppingCart()

final class _ShoppingCart {
    private(set) var items: [CartItem] = []
}

extension _ShoppingCart {
    var total: Double {
        get { return items.reduce(0.0) { value, item in
            value + item.subTotal
            }
        }
    }
    func remove(item: MenuItem) {
        guard let index = items.firstIndex(where: { $0.item == item }) else { return}
        items.remove(at: index)
    }
    func add(item: MenuItem) {
        let itemTest = items.filter { $0.item == item }
        
        if itemTest.first != nil {
            itemTest.first!.quantity += 1
        } else {
            items.append(CartItem(item: item))
        }
    }
}
