//
//  orderStructure.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 7/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation


struct Order {
    var orderNumber: String
    var customerName: String
    var orderedItems: String
    
    init(
         orderNumber: String = "",
         customerName: String = "",
         orderedItems: String = "") {
        
        self.customerName = customerName
        self.orderedItems = orderedItems
        self.orderNumber = orderNumber
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        orderNumber = data["orderNumber"] as? String ?? ""
        customerName = data["customerName"] as? String ?? ""
        orderedItems = data["orderedItems"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(order: Order) -> [String: Any] {
        let data: [String: Any] = [
            "orderNumber": order.orderNumber,
            "customerName": order.customerName,
            "orderedItems": order.orderedItems,
        ]
        return data
    }
}
