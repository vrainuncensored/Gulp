//
//  FirebaseFunctions.swift
//  gulp
//
//  Created by Vrain Ahuja on 8/23/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import Firebase

let cloudFunctions = _FirebaseFunctions()

final class _FirebaseFunctions{

    func notify() {
        Functions.functions().httpsCallable("notify").call{(result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                //self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                return
            }
            //this is the code that has been executed for after a successful charge has been made
            print("success")
        }
    }
    func notifyCustomer(phoneNumber: String) {
        let data : [String : String] = [
            "phoneNumber" : phoneNumber,
        ]
        Functions.functions().httpsCallable("notifyCustomer").call(data) {(result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                //self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                return
            }
            //this is the code that has been executed for after a successful charge has been made
            print("success")
        }
    }
}
