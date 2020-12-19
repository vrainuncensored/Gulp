//
//  truckService.swift
//  gulp
//
//  Created by Vrain Ahuja on 8/23/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let truckservice = _TruckService()

final class _TruckService{
    
    var truck = Truck()
    let auth = Auth.auth()
    let db = Firestore.firestore()

    
    
    func getTruck(UUID: String) {
        
        let truckRef = db.collection("merchant").document(UUID)
        truckRef.getDocument { (query , err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let data = query?.data() else {return}
            self.truck = Truck.init(data: data)
        }
    }
    
    
        
    
    
    func updateCart(price: Double, item: String ) {
//        let cartRef = db.collection("users").document(user.id).collection("Cart")
//        var cartPriceTotal = 0.0
//        var carPriceTotal = cartPriceTotal + price
        //let selectedItems : [String] =
    }
//    func logoutUser(){
//        userListner?.remove()
//        userListner = nil
//        cartListner?.remove()
//        cartListner = nil
//        user = User()
//        cart.removeAll()
//
//    }
    
}
