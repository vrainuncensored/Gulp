//
//  StripeConnect.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 3/21/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

let BackendAPIBaseURL: String = "" // Set to the URL of your backend server


class StripeConnect: UIViewController {

    @IBOutlet weak var stripeButton: UIButton!
    @IBOutlet weak var refreshSetting: UIButton!
    @IBOutlet weak var payoutInterval: UIButton!
    
    var user = Merchant(email: "", id: "", stripeId: "acct_1IXrdzQfQzdPjHUl", name: "", locationCoordinates: GeoPoint(latitude: 0.0, longitude: 0.0), phoneNumber: "", cuisine: "", acceptingOrders: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        userservice.getUser()
        let connectWithStripeButton = UIButton(type: .system)
        stripeButton.setTitle("Connect with Stripe", for: .normal)
        stripeButton.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
        view.addSubview(stripeButton)
        refreshSetting.addTarget(self, action: #selector(resetUserInfo), for: .touchUpInside)

        payoutInterval.addTarget(self, action: #selector(setPayoutValue), for: .touchUpInside)        // Do any additional setup after loading the view.
        self.navigationItem.title = "Profile"
        let userLogo = "person"
        let archivesSFSymbol = "scroll"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
        let archiveImage = UIImage(systemName: archivesSFSymbol, withConfiguration: buttonConfig)
        
        let button = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(resetUserInfo))
        let archiveButton = UIBarButtonItem(image: archiveImage, style: .plain, target: self, action: #selector(resetUserInfo))
       // let addAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(segueTo))
        navigationItem.rightBarButtonItem = button
    }
    @objc func resetUserInfo() {
//            print("print fucking something")
//            let currentUser = Auth.auth().currentUser
//            print (currentUser!.uid)
//            if let currentUser = currentUser {
//                let userRef = Firestore.firestore().collection("merchant").document(currentUser.uid)
//            userRef.getDocument { (query , err) in
//                        if let error = err {
//                            print(error.localizedDescription)
//                            print("the GetUser function is not working. This is the issue")
//                            return
//                        }
//                        guard let data = query?.data() else {return}
//                        self.user = Merchant.init(data: data)
//                        print(self.user)
//                    }
//            } else {
//                print("there is something wrong with getting the users's id")
//            }
        userservice.getUser()
        print(userservice.user)
        print(userservice.user.stripeId)
    }
    @objc
        func didSelectConnectWithStripe() {
            if userservice.isGuest == false {
            stripeAccountLinks(user: userservice.user)
//                while link != "" {
//                    let accountURL = URL(string: link)
//                    let safariViewController = SFSafariViewController(url: accountURL!)
//                    safariViewController.delegate = self
//                    self.present(safariViewController, animated: true, completion: nil)
//                }
               
            print(link)
            } 
        }
    @objc func setPayoutValue() {
        print(userservice.user.stripeId)
        let data = ["stripeId": "acct_1IXrdzQfQzdPjHUl", "day" : "monday" ]
        Functions.functions().httpsCallable("updatePayoutDate").call(data){(result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                //self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                return
            }
            print(result?.data)
    }
    }
//    func previewScreen() {
//        //let safariViewController = SFSafariViewController(url: accountURL!)
//        safariViewController.delegate = self
//        self.present(safariViewController, animated: true, completion: nil)
//    }
    func stripeAccountLinks (user: Merchant)  {
        var urlresult = ""
        let stripeId = user.stripeId
        let data : [String : String ]  = [
            "stripeId" : stripeId
        ]
        Functions.functions().httpsCallable("createAccountsLink").call(data){(result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                //self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                return
            }
            //this is the code that has been executed for after a successful charge has been made
            print("success")
           // if let result = source["results"] as? [String]
            urlresult = result!.data as! String
            print(urlresult)
            let accountURL = URL(string: urlresult)
            let safariViewController = SFSafariViewController(url: accountURL!)
            safariViewController.delegate = self
            self.present(safariViewController, animated: true, completion: nil)
            
//            let json = try? JSONSerialization.data(withJSONObject: data, options: []) as? [String : Any]
//            let id = json["url"] as? String
//            let accountURL = URL(string: id)
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

extension StripeConnect: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}
