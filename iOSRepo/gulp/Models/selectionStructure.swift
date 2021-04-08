//
//  selectionStructure.swift
//  gulp
//
//  Created by vrain ahuja on 4/3/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import Foundation

struct Selection {
    var required: Bool
    var name: String
    var selectionNumber: String
    var options: [String: Int]

    init(
        required: Bool = false,
        name: String = "",
        selectionNumber: String = "",
        options: [String: Int]
    ) {

        self.required = required
        self.name = name
        self.selectionNumber = selectionNumber
        self.options = options
    }
    init(data: [String: Any]) {
         let testValue = data["selection"]  as! Dictionary<String, Any>
         name = testValue["name "] as! String
         required = testValue["required"] as! Bool
         selectionNumber = testValue["selectionNumber"] as! String
         options = ["hello": 5]
    }
}
