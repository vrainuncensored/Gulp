//
//  optionStructure.swift
//  gulp
//
//  Created by vrain ahuja on 4/7/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import Foundation

struct SelectionOption {
    var price: Double
    var name : String
    var description: String?
    
    
    init(
        price: Double = 0.00 ,
        name: String = "",
        description: String = ""
        )
        {
        self.name = name
        self.price = price
        self.description = description
    }
    
    //the initializer for taking firebase results into useable data
//    init(data: [String: Any], selection: Selection) {
//        price = data["price"] as? Double ?? 0.00
//        itemCategory = data["itemCategory"] as? String ?? ""
//        name = data["name"] as? String ?? ""
//        description = data["description"] as? String ?? ""
//        toppings = data["Toppings"] as? [String] ?? [""]
//        options = data["Options"] as? [String] ?? [""]
//        selectionChoice = selection
//
//    }
    //this is the code needed to take input and send to the database
//    static func modelToData(menuItem: MenuItem) -> [String: Any] {
//        let data: [String: Any] = [
//            "price": menuItem.price,
//            "itemCategory": menuItem.itemCategory,
//            "name": menuItem.name,
//            "description" : menuItem.description,
//            "toppings" : menuItem.toppings,
//            "options" : menuItem.toppings
//        ]
//        return data
//    }
}
