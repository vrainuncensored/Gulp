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
        let data = [
            "apiVersion": apiVersion,
            "customer_id": userservice.user.stripeId
        ]
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { (result, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
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
