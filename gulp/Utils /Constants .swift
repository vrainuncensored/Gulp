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
