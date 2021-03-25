//
//  ConnectOnboardViewController.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 7/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import SafariServices

class ConnectOnboardViewController: UIViewController {
    let state: String = generateRandomNumber()// generate a unique value for this
    let clientID: String = "ca_HDc2f2N9XftwO50jLFIp0uDsSx1CZqOS"// the client ID found in your platform settings

    // ...

    override func viewDidLoad() {
        super.viewDidLoad()

        let connectWithStripeButton = UIButton(type: .system)
        connectWithStripeButton.setTitle("Connect with Stripe", for: .normal)
        connectWithStripeButton.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
        view.addSubview(connectWithStripeButton)

        // ...
    }

    @objc
    func didSelectConnectWithStripe() {
        // set the redirect_uri to a deep link back into your app to automatically
        // detect when the user has completed the onboarding flow
        let redirect = "https://www.example.com/connect-onboard-redirect"

        // Construct authorization URL
        guard let authorizationURL = URL(string: "https://connect.stripe.com/express/oauth/authorize?client_id=\(clientID)&state=\(state)&redirect_uri=\(redirect)") else {
            return
        }

        let safariViewController = SFSafariViewController(url: authorizationURL)
        safariViewController.delegate = self

        present(safariViewController, animated: true, completion: nil)
    }

    // ...
}

extension ConnectOnboardViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}


