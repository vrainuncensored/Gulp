//
//  AccountPage.swift
//  gulp
//
//  Created by vrain ahuja on 2/2/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountPage: UIViewController {
   
    //Button Outlets
    @IBOutlet weak var SignOutButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupSignOutButton()
        // Do any additional setup after loading the view.
    }
    
    func settupSignOutButton() {
        SignOutButton.addTarget(self, action: #selector(SignOutFunction), for: .touchUpInside)
        SignOutButton.setTitle("Sign Out", for: .normal)
        SignOutButton.showsTouchWhenHighlighted = true
        SignOutButton.layer.cornerRadius = 5
        SignOutButton.layer.borderWidth = 1
        SignOutButton.layer.borderColor = CG_Colors.red
        SignOutButton.layer.backgroundColor = CG_Colors.red
        SignOutButton.setTitleColor(.white, for: .normal)
    }

    @objc func SignOutFunction(){
        let firebaseAuth = Auth.auth()
       do {
         userservice.logoutUser()
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
       }
         
        
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
