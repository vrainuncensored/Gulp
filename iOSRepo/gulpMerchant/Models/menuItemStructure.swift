//
//  menuItemStricture.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/3/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

struct MenuItem {
    var price: String
    var itemCategory: String
    var name: String
    
    init(
         price: String = "0.0",
         itemCategory: String = "",
         name: String = "") {
        
        self.itemCategory = itemCategory
        self.name = name
        self.price = price
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        price = data["price"] as? String ?? "0.0"
        itemCategory = data["itemCategory"] as? String ?? ""
        name = data["name"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(menuItem: MenuItem) -> [String: Any] {
        let data: [String: Any] = [
            "price": menuItem.price,
            "itemCategory": menuItem.itemCategory,
            "name": menuItem.name,
        ]
        return data
    }
}

