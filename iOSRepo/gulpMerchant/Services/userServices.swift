//
//  userServices.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 6/8/20.
//  Copyright © 2020 Gulp. All rights reserved.
//
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth

let userservice = _UserService()

final class _UserService{
    
    var user = Merchant(email: "", id: "", stripeId: "acct_1IXrdzQfQzdPjHUl", name: "", locationCoordinates: GeoPoint(latitude: 0.0, longitude: 0.0), phoneNumber: "", cuisine: "", acceptingOrders: false)
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListner : ListenerRegistration? = nil
    
    var isGuest : Bool {
        guard let isGuest = auth.currentUser else {
            return true
        }
        return false
    }
    
    func getUser() {
        let currentUser = Auth.auth().currentUser
        if let currentUser = currentUser {
            let userRef = db.collection("merchant").document(currentUser.uid)
        userRef.getDocument { (query , err) in
                    if let error = err {
                        print(error.localizedDescription)
                        print("the GetUser function is not working. This is the issue")
                        return
                    }
                    guard let data = query?.data() else {return}
                    self.user = Merchant.init(data: data)
                    print(self.user)
                }
        } else {
            print("there is something wrong with getting the users's id")
        }
    }
    func signOutUser() {
        self.user = Merchant(email: "", id: "", stripeId: "Hello", name: "user signed out", locationCoordinates: GeoPoint(latitude: 0.0, longitude: 0.0), phoneNumber: "", cuisine: "", acceptingOrders: false)
    }
    
}
func generateRandomNumber() -> String {
    let uuid = UUID().uuidString
    return(uuid)
}
    
