//
//   cartItemStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/30/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

//import Foundation
//
//struct CartItem {
//    var name: String
//    var protein: String
//    var side: String
//    var test: [String : Double]
//
//
//   init(
//    test: [[String:Double]] = [["": 0]],
//         name: String = "",
//         protein: String ,
//         side : String = ""
//         ) {
//        self.test = test
//        self.name = name
//        self.protein = protein
//        self.side = side
//    }
//    //the initializer for taking firebase results into useable data
//    init(data: [String: Any]) {
//        name = data["name"] as? String ?? ""
//        protein = data["protein"] as? String ?? ""
//        side = data["side"] as? String ?? ""
//        test = data["test"] as? [String : Double] ?? [:]
//
//   }
//    //this is the code needed to take input and send to the database
//    static func modelToData(cartItem: CartItem) -> [String: Any] {
//        let data: [String: Any] = [
//            "name": cartItem.name,
//            "test": cartItem.test
//        ]
//        return data
//    }
//}
