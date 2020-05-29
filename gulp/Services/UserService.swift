//
//  UserService.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/28/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import Firebase

let userservice = _UserService()

final class _UserService{
    
    var user = User()
    var cart = [MenuItem]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListner : ListenerRegistration? = nil
    var cartListner : ListenerRegistration? = nil
    
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
            self.user = User.init(data: data)
        })
        
        let cartRef = userRef.collection("Cart")
        cartListner = cartRef.addSnapshotListener({ (snap, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
        snap?.documents.forEach({ (document) in
            let cartSelection = MenuItem.init(data: document.data())
            self.cart.append(cartSelection)
                
            })
            
        })
        
    }
   
    
}

