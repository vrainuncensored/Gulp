//
//  userStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/23/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation



struct User {
    var email : String
    var id: String
    var stripeId: String
    var name: String
    var phoneNumber: String
    
    init(email: String = "",
         id: String = "",
         stripeId: String = "",
         name: String = "",
         phoneNumber: String = "") {
        
        self.email = email
        self.id = id
        self.stripeId = stripeId
        self.name = name
        self.phoneNumber = phoneNumber
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
        name = data["name"] as? String ?? ""
        phoneNumber = data["phoneNumber"] as? String ?? ""

    }
    //this is the code needed to take input and send to the database
    static func modelToData(user: User) -> [String: Any] {
        let data: [String: Any] = [
            "email": user.email,
            "id": user.id,
            "stripeId": user.stripeId,
            "name": user.name,
            "phoneNumber": user.phoneNumber
        ]
        return data
    }    
}
