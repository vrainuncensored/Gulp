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
    private let stripeCreditCardCut = 0.029
    private let flatFeeCents = 30
    private let salesTaxRate = 0.0725
    var shippingFees = 0
    private(set) var listOfNames: [String] = []
}

extension _ShoppingCart {
//    var total: Double {
//        get { return items.reduce(0.0) { value, item in
//            value + item.subTotal
//            }
//        }
//    }
    
    var itemsOrdered : [String] {
        for item in items {
            let name = item.item.name
            self.listOfNames.append(name)
        }
         return listOfNames
    }
    
    var subtotal: Int {
        var amount = 0
        for item in items {
            let pricePennies = Int(item.subTotal * 100)
            amount += pricePennies
        }
        
        return amount
    }
    
    var processingFees : Int {
        if subtotal == 0 {
            return 0
        }
        
        let sub = Double(subtotal)
        let feesAndSub = Int(sub * stripeCreditCardCut) + flatFeeCents
        return feesAndSub
    }
    var tax : Int {
        let sub = Double(subtotal)
        let salesTax = Int(sub * salesTaxRate)
        return salesTax
    }
    
    
    var totalCost : Int {
        if subtotal == 0 {
            return 0
        }
        return subtotal + processingFees + tax
    }
    
    
    func remove(item: MenuItem) {
        guard let index = items.firstIndex(where: { $0.item == item }) else { return}
        items.remove(at: index)
    }
    func add(item: MenuItem) {
        let itemTest = items.filter { $0.item == item }
        
        if itemTest.first != nil {
            itemTest.first!.quantity += Int(item.price)
        } else {
            items.append(CartItem(item: item))
        }
    }
    func clearCart() {
        items.removeAll()
    }
}
