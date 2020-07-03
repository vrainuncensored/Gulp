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

    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

struct CG_Colors {
    static let darkPurple: CGColor = #colorLiteral(red: 0.8442266583, green: 0.493614614, blue: 0.6640961766, alpha: 1)
    static let lightPurple: CGColor = #colorLiteral(red: 0.9710480571, green: 0.8799498677, blue: 0.9214171171, alpha: 1)
    static let blue: CGColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
    static let gold: CGColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
    static let white:CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}
struct UI_Colors {
    static let darkPurple: UIColor = #colorLiteral(red: 0.8442266583, green: 0.493614614, blue: 0.6640961766, alpha: 1)
    static let lightPurple: UIColor = #colorLiteral(red: 0.9710480571, green: 0.8799498677, blue: 0.9214171171, alpha: 1)
    static let blue: UIColor = #colorLiteral(red: 0.6544036865, green: 0.8693754673, blue: 0.9504790902, alpha: 1)
    static let gold: UIColor = #colorLiteral(red: 0.9457510114, green: 0.8288354874, blue: 0.29682073, alpha: 1)
}
