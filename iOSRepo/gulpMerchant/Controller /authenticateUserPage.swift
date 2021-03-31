//
//  authenticateUserPage.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 3/31/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase

class authenticateUserPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  userservice.isGuest == true {
            segueToSignInMerchant()
            print("is guest")
        } else if userservice.isGuest == false{
        print("is not a guest")
        userservice.getUser()
        segueToHomePageMerchant()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
