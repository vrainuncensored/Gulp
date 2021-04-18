//
//  Constants .swift
//  gulp
//
//  Created by Vrain Ahuja on 6/14/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import UIKit

//a comprehensive list of all the segues in the app. Instead of typing out the name in VC Controller code, you will instead use Segue.(\"name of segue"). Makes code easier to read and more organized
//struct Segue {
//    static let segueToUserCart = "segueToUserCart"
//}
struct Segues {
    static let ToUserCart = "segueToUserCart"
}


extension UIViewController {

    //alerts
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //segues
    func segueToHome() {
      let loginFlow = UIStoryboard(name: "Main", bundle: nil)
      let controller = loginFlow.instantiateViewController(identifier: "mainFlow")
      present(controller, animated: true, completion: nil)
    }

func segueToOrders() {
      let loginFlow = UIStoryboard(name: "Main", bundle: nil)
      let controller = loginFlow.instantiateViewController(identifier: "entry")
      present(controller, animated: true, completion: nil)
    }
}

struct CG_Colors {
    static let darkPurple: CGColor = #colorLiteral(red: 1, green: 0.2923217118, blue: 1, alpha: 1)
    static let lightPurple: CGColor = #colorLiteral(red: 1, green: 0.6926438212, blue: 1, alpha: 1)
    static let blue: CGColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
    static let gold: CGColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
    static let white:CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let red:CGColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    static let black:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let purple:CGColor = #colorLiteral(red: 0.5221467614, green: 0.02739732899, blue: 0.8998202682, alpha: 1)
    static let blueTest:CGColor = #colorLiteral(red: 0.5107015371, green: 0.5777968764, blue: 0.9307124019, alpha: 1)
    static let grey:CGColor = #colorLiteral(red: 0.4899424314, green: 0.5141664743, blue: 0.5398099422, alpha: 1)
}
struct UI_Colors {
    static let darkPurple: UIColor = #colorLiteral(red: 1, green: 0.2923217118, blue: 1, alpha: 1)
    static let lightPurple: UIColor = #colorLiteral(red: 1, green: 0.6926438212, blue: 1, alpha: 1)
    static let blue: UIColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
    static let gold: UIColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
    static let white:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let red:UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    static let black:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let purple:UIColor = #colorLiteral(red: 0.5221467614, green: 0.02739732899, blue: 0.8998202682, alpha: 1)
    static let blueTest:UIColor = #colorLiteral(red: 0.5107015371, green: 0.5777968764, blue: 0.9307124019, alpha: 1)
    static let grey:UIColor = #colorLiteral(red: 0.4899424314, green: 0.5141664743, blue: 0.5398099422, alpha: 1)

}


extension Int {
 func penniesToFormattedCurrency() -> String {
        // if the int this function is being called on is 1234
        // dollars = 1234/100 = $12.34
        let dollars = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let dollarString = formatter.string(from: dollars as NSNumber) {
            return dollarString
        }
        
        return "$0.00"
    }

}

extension Double {
 func penniesToFormattedCurrencyDouble() -> String {
        // if the int this function is being called on is 1234
        // dollars = 1234/100 = $12.34
        let dollars = Double(self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let dollarString = formatter.string(from: dollars as NSNumber) {
            return dollarString
        }
        
        return "$0.00"
    }

}
