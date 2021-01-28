//
//  FirebaseFunctions.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 1/21/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import Foundation
import Firebase

let cloudFunctions = _FirebaseFunctions()

final class _FirebaseFunctions {
    
    func  orderAcceptedNotification() {
        let data : [String : String] = [
            "phoneNumber" : "+17038191285",
            "truckName" : "Fernando's"
        ]
        Functions.functions().httpsCallable("orderAccepted").call(data){(result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                //self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                return
            }
            //this is the code that has been executed for after a successful charge has been made
            print("success")
        }
    }
    func orderCompletedDatabase (orderTicket : Order) {
        let data = Order.modelToData(order: orderTicket)
        let merchantTicket = Firestore.firestore().collection("merchant").document("HKunSIdEcuWivHMbQLhGlM5Htrq2").collection("completedOrders").document(orderTicket.orderNumber)
    merchantTicket.setData(data){ err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
        }
    }
    }
    func removeCompletedOrder (orderTicket: Order) {
        let data = Order.modelToData(order: orderTicket)
        let merchantTicket = Firestore.firestore().collection("merchant").document("HKunSIdEcuWivHMbQLhGlM5Htrq2").collection("orders").document(orderTicket.orderNumber).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
    }
    
}

}
