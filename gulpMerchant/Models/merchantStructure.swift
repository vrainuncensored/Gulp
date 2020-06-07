//
//  merchantStructure.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/3/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation



struct Merchant {
    var email : String
    var id: String
    var stripeId: String
    var name: String
    
    init(email: String = "",
         id: String = "",
         stripeId: String = "",
         name: String = "") {
        
        self.email = email
        self.id = id
        self.stripeId = stripeId
        self.name = name
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
        name = data["name"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(merchant: Merchant) -> [String: Any] {
        let data: [String: Any] = [
            "email": merchant.email,
            "id": merchant.id,
            "stripeId": merchant.stripeId,
            "name": merchant.name
        ]
        return data
    }
}
