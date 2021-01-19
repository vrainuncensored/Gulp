//
//  ViewController.swift
//  gulp
//
//  Created by Vrain Ahuja on 3/26/20.
//  Copyright © 2020 Gulp. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase


class ViewController: UIViewController {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//          }
//        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error{
//                print("error")
//            }
//            print(authResult)
//            self.performSegue(withIdentifier: "HomeSegue", sender: self)
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
    
/*
 This method will be invoked after iOS app's view is loaded.
 */
    
    @IBOutlet weak var mainLogo: UIImageView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var slogan: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
        
        let test = UIImage(named: "gulplogo")
        slogan.textColor  = UI_Colors.darkPurple
        slogan.font = UIFont(name: "AvenirNext-Bold" , size: 40.0)
        slogan.textColor = UIColor.black

        mainLogo.image = test
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = CG_Colors.red
        signupButton.setTitle("Sign Up", for: .normal)
        
        signinButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = CG_Colors.red
        signinButton.setTitle("Sign In", for: .normal)
    
        self.view.backgroundColor = UI_Colors.white

    }

    @objc func buttonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
    }
    @objc func loginAction(sender: UIButton!) {
        let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
        let controller = loginFlow.instantiateViewController(identifier: "loginPage")
        present(controller, animated: true, completion: nil)
      }
    @objc func signUpAction(sender: UIButton!) {
          let loginFlow = UIStoryboard(name: "LoginFlowCustomer", bundle: nil)
          let controller = loginFlow.instantiateViewController(identifier: "signupPage")
          present(controller, animated: true, completion: nil)
        }
//    func facebookLogin() {
   // let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//          if let error = error {
//            let authError = error as NSError
//            if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
//              // The user is a multi-factor user. Second factor challenge is required.
//              let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//              var displayNameString = ""
//              for tmpFactorInfo in (resolver.hints) {
//                displayNameString += tmpFactorInfo.displayName ?? ""
//                displayNameString += " "
//              }
//              self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
//                var selectedHint: PhoneMultiFactorInfo?
//                for tmpFactorInfo in resolver.hints {
//                  if (displayName == tmpFactorInfo.displayName) {
//                    selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                  }
//                }
//                PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
//                  if error != nil {
//                    print("Multi factor start sign in failed. Error: \(error.debugDescription)")
//                  } else {
//                    self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
//                      let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
//                      let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
//                      resolver.resolveSignIn(with: assertion!) { authResult, error in
//                        if error != nil {
//                          print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
//                        } else {
//                          self.navigationController?.popViewController(animated: true)
//                        }
//                      }
//                    })
//                  }
//                }
//              })
//            } else {
//              self.showMessagePrompt(error.localizedDescription)
//              return
//            }
//            // ...
//            return
//          }
//          // User is signed in
//          // ...
//        }
//    }
    
}


        
        
        
        
        
   
