//
//  StripeApi.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import Stripe
import FirebaseFunctions

let StripeApi = _StripeApi()

class _StripeApi: NSObject, STPCustomerEphemeralKeyProvider {

    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let data : [String : Any] = [
            "apiVersion" : apiVersion ,
            "customer_id" : "cus_JI6CR2r3ivVwFn"
        ]
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { (result, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                print(error.localizedDescription.description)
                print("EphemeralIssue")
                completion(nil, error)
                return
            }
            
            guard let key = result?.data as? [String: Any] else {
                completion(nil,nil)
                return
            }
            completion(key, nil)
    }
}
}

