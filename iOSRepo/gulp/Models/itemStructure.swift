//
//  itemStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/8/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

struct MenuItem {
    var price: Double
    var itemCategory: String
    var name: String
    var description: String?
    var toppings: [String]?
    var options: [String]?
    var selectionChoice: Selection
    
    
    init(
        price: Double = 0.00 ,
        itemCategory: String = "",
        name: String = "",
        description: String = "",
        toppings: [String] = [""],
        options: [String] = [""],
        selectionChoice: Selection
        )
        {
        self.itemCategory = itemCategory
        self.name = name
        self.price = price
        self.description = description
        self.toppings = toppings
        self.options = options
        self.selectionChoice = selectionChoice
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any], selection: Selection) {
        price = data["price"] as? Double ?? 0.00
        itemCategory = data["itemCategory"] as? String ?? ""
        name = data["name"] as? String ?? ""
        description = data["description"] as? String ?? ""
        toppings = data["Toppings"] as? [String] ?? [""]
        options = data["Options"] as? [String] ?? [""]
        selectionChoice = selection

    }
    //this is the code needed to take input and send to the database
    static func modelToData(menuItem: MenuItem) -> [String: Any] {
        let data: [String: Any] = [
            "price": menuItem.price,
            "itemCategory": menuItem.itemCategory,
            "name": menuItem.name,
            "description" : menuItem.description,
            "toppings" : menuItem.toppings,
            "options" : menuItem.toppings
        ]
        return data
    }
}
extension MenuItem {
// MARK: Equatable
static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
    return lhs.name == rhs.name
}
}

