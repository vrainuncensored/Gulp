//
//  AppDelegate.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/1/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase
import Stripe
import FirebaseDynamicLinks


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Stripe.setDefaultPublishableKey("pk_test_LdIj43U3AT5gKjMChrv0cdFV00GsaCO40A")
        return true
    }
    func handelIncomingDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else {
            print("The link is not working!")
            return
        }
        print("your url is \(url.absoluteString)")
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            print("incoming URL is \(incomingURL)")
            let linkHandeled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { (dynamicLink, error ) in
                guard error == nil else {
                    print(" the error is \(error!.localizedDescription)")
                    return
                }
                if let dynamicLink = dynamicLink {
                    self.handelIncomingDynamicLink(dynamicLink)
                }
            }
            if linkHandeled {
                return true
            } else {
                return false
            }
        }
        return false
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

