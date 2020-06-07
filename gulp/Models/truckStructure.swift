//
//  Menu.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/20/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation

struct Truck {
    var email: String
    var id: String
    var name: String
    var stripeId: String
    
    init(
         email: String = "",
         id: String = "",
         name: String = "",
         stripeId: String = "") {
        
        self.email = email
        self.name = name
        self.id = id
        self.stripeId = stripeId
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        email = data["email"] as? String ?? ""
        id = data["id"] as? String ?? ""
        name = data["name"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(truck: Truck) -> [String: Any] {
        let data: [String: Any] = [
            "email": truck.email,
            "id": truck.id,
            "name": truck.name,
            "stripeId": truck.stripeId
        ]
        return data
    }
}
