//
//  userServices.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 6/8/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import Firebase

let userservice = _UserService()

final class _UserService{
    
    var user = Merchant()
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
        guard let currentUser = auth.currentUser else {return}
        
        let userRef = db.collection("users").document(currentUser.uid)
        userListner = userRef.addSnapshotListener({ (snap, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let data = snap?.data() else {return}
            //self.user = User.init(data: data)
        })
