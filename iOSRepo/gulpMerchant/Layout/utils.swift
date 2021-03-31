//
//  utils.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 3/20/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import Foundation
import UIKit


//struct CG_Colors {
//    static let darkPurple: CGColor = #colorLiteral(red: 0.8442266583, green: 0.493614614, blue: 0.6640961766, alpha: 1)
//    static let lightPurple: CGColor = #colorLiteral(red: 0.9710480571, green: 0.8799498677, blue: 0.9214171171, alpha: 1)
//    static let blue: CGColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
//    static let gold: CGColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
//    static let white:CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    static let red:CGColor = #colorLiteral(red: 0.9373852015, green: 0.08471465856, blue: 0.05553941429, alpha: 1)
//    static let black:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    static let purple:CGColor = #colorLiteral(red: 0.5221467614, green: 0.02739732899, blue: 0.8998202682, alpha: 1)
//    static let blueTest:CGColor = #colorLiteral(red: 0.5107015371, green: 0.5777968764, blue: 0.9307124019, alpha: 1)
//
//}

//struct UI_Colors {
//    static let darkPurple: UIColor = #colorLiteral(red: 0.8442266583, green: 0.493614614, blue: 0.6640961766, alpha: 1)
//    static let lightPurple: UIColor = #colorLiteral(red: 0.9710480571, green: 0.8799498677, blue: 0.9214171171, alpha: 1)
//    static let blue: UIColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
//    static let gold: UIColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
//    static let white:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    static let red:UIColor = #colorLiteral(red: 0.9373852015, green: 0.08471465856, blue: 0.05553941429, alpha: 1)
//    static let black:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    static let purple:UIColor = #colorLiteral(red: 0.5221467614, green: 0.02739732899, blue: 0.8998202682, alpha: 1)
//    static let blueTest:UIColor = #colorLiteral(red: 0.5107015371, green: 0.5777968764, blue: 0.9307124019, alpha: 1)
//
//}
extension UIViewController {

    //alerts
//    func simpleAlert(title: String, msg: String) {
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    
    //segues
    func segueToSignInMerchant() {
      let loginFlow = UIStoryboard(name: "LoginFlow", bundle: nil)
      let controller = loginFlow.instantiateViewController(identifier: "loginPage")
      present(controller, animated: true, completion: nil)
    }
    func segueToHomePageMerchant() {
        let loginFlow = UIStoryboard(name: "Main", bundle: nil)
        let viewController = loginFlow.instantiateViewController(withIdentifier: "entry") as! UITabBarController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
//func segueToMainFlow() {
//      let loginFlow = UIStoryboard(name: "Main", bundle: nil)
//      let controller = loginFlow.instantiateViewController(identifier: "entry")
//      present(controller, animated: true, completion: nil)
//    }
}

let tabConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
let tabFontAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)]
struct tabIcons {
    static let ordersIcon = "tray.and.arrow.down"
    static let menuIcon = "table.badge.more"
    static let locationIcon = "location.circle.fill"
    static let accountIcon = "person"
}
struct tabLabels{
    static let orderLabel = "Orders"
    static let menuLabel = "Menu Items"
    static let locationLabel = "Location"
    static let accountLabel = "Account"
}
