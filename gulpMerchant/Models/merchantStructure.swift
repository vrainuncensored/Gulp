//
//  merchantStructure.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/3/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase



struct Merchant {
    var email : String
    var id: String
    var stripeId: String
    var name: String
    var locationCoordinates: GeoPoint?

    init(email: String = "",
         id: String = "",
         stripeId: String = "",
         name: String = "",
         locationCoordinates:GeoPoint = GeoPoint(latitude: null ,longitude: null) ) {
        
        self.email = email
        self.id = id
        self.stripeId = stripeId
        self.name = name
        self.locationCoordinates = locationCoordinates
    }
    //the initializer for taking firebase results into useable data
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
        name = data["name"] as? String ?? ""
        locationCoordinates = data["locationCoordinates"] as? CLLocationCoordinate2D ?? CLLocationCoordinate2D()

    }
    //this is the code needed to take input and send to the database
    static func modelToData(merchant: Merchant) -> [String: Any] {
        let data: [String: Any] = [
            "email": merchant.email,
            "id": merchant.id,
            "stripeId": merchant.stripeId,
            "name": merchant.name,
            "locationCoordinates": merchant.locationCoordinates ?? CLLocationCoordinate2D(latitude:0, longitude:0)
        ]
        return data
    }
}
