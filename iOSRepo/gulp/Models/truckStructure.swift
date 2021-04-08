//
//  Menu.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/20/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

struct Truck {
    var email: String
    var id: String
    var name: String
    var stripeId: String
    var locationCoordinates: GeoPoint
    var phoneNumber: String
    var cuisine: String
    var companyLogoURL: String?
    var categories : [String]
    
    init(
         email: String = "",
         id: String = "",
         name: String = "",
         stripeId: String = "",
         locationCoordinates: GeoPoint = GeoPoint(latitude:0, longitude:0),
         phoneNumber: String = "",
        cuisine: String = "",
        companyLogoURL: String = "",
        categories: [String] = [""]
        ) {
        
        self.email = email
        self.name = name
        self.id = id
        self.stripeId = stripeId
        self.locationCoordinates = locationCoordinates
        self.phoneNumber = phoneNumber
        self.cuisine = cuisine
        self.companyLogoURL = companyLogoURL
        self.categories = categories
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        email = data["email"] as? String ?? ""
        id = data["id"] as? String ?? ""
        name = data["name"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
        locationCoordinates = data["locationCoordinates"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0)
        phoneNumber = data["phoneNumber"] as? String ?? ""
        cuisine = data["cuisine"] as? String ?? ""
        companyLogoURL = data["companyLogoURL"] as? String ?? ""
        categories = data["categories"] as? [String] ?? [""]
    }
    //this is the code needed to take input and send to the database
    static func modelToData(truck: Truck) -> [String: Any] {
        let data: [String: Any] = [
            "email": truck.email,
            "id": truck.id,
            "name": truck.name,
            "stripeId": truck.stripeId,
            "locationCoordinates": truck.locationCoordinates,
            "phoneNumber": truck.phoneNumber,
            "cuisine" : truck.cuisine,
            "companyLogoURL" : truck.companyLogoURL ?? nil,
            "categories" : truck.categories
        ]
        return data
    }
}
