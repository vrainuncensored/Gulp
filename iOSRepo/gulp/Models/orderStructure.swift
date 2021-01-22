//
//  orderStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/31/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Order {
    var customerName : String
    var merchantId : String
    var items : [String]
    var timestamp : Timestamp
    var total: Int
    var additionalRequests:String?
    var orderNumber:String


    init(
        customerId: String = "",
        merchantId: String = "",
        items : [String] = [""],
        timestamp : Timestamp,
        total: Int = 0,
        additionalRequests: String,
        orderNumber:String
         ) {

        self.customerName = customerId
        self.merchantId = merchantId
        self.items = items
        self.timestamp = timestamp
        self.total = total
        self.additionalRequests = additionalRequests
        self.orderNumber = orderNumber

    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        customerName = data["customerId"] as? String ?? ""
        merchantId = data["merchantId"] as? String ?? ""
        items = data["items"] as? [String] ?? [""]
        timestamp = data["timestamp"] as? Timestamp ??  Timestamp()
        total = data["total"] as? Int ?? 0
        additionalRequests = data["additionalRequests"] as? String ?? ""
        orderNumber = data["orderNumber"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(order: Order) -> [String: Any] {
        let data: [String: Any] = [
            "customerId": order.customerName,
            "merchantId" : order.merchantId,
            "items" : order.items,
            "timestamp" : order.timestamp,
            "total" : order.total,
            "additionalRequests" : order.additionalRequests,
            "orderNumber" : order.orderNumber
        ]
        return data
    }
}
