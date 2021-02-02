//
//  HomePageVC.swift
//  gulp
//
//  Created by vrain ahuja on 2/1/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            segueToTrucksPage()
        } else {
            validateUser()
        }
        

        // Do any additional setup after loading the view.
    }
    
    func segueToTrucksPage(){
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
       }
    func validateUser() {
        let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
        let controller = loginFlow.instantiateViewController(identifier: "validateUserPage")
        present(controller, animated: true, completion: nil)
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
