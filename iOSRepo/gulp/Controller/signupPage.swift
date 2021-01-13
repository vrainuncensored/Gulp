//
//  signupPage.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import AuthenticationServices
//import CryptoKit


class signupPage: UIViewController, LoginButtonDelegate {
        let db = Firestore.firestore()
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
          }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print("error")
            }
            print(authResult)
//            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
         
    }
    //Text Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordConfirmation: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    //Button Outlets
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    //Label Outlets
    @IBOutlet weak var phoneDisclamer: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup for the TextFields
        setupUserNameField()
        setupUserEmailField()
        setupUserPasswordField()
        setupUserPasswordConfirmationField()
        setupUserPhoneNumberField()
        
        //setup for Labels
        setupPhoneDisclamer()
        
        //setup for Buttons
        setupSignUpButton()
        setupSignInButton()
        settupFacebookButton()
//        settupAppleLoginButton()
        
        
        
        //establishing delegates
        userEmail.delegate = self
        userPassword.delegate = self
        userPasswordConfirmation.delegate = self
        userName.delegate = self
        
    }
    func setupUserNameField() {
        userName.attributedPlaceholder = NSAttributedString(string:"Your full name" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userName.borderStyle = UITextField.BorderStyle.none
    }
    func setupUserEmailField() {
        userEmail.autocapitalizationType = UITextAutocapitalizationType.none
        userEmail.placeholder = "Your email address"
        userEmail.attributedPlaceholder = NSAttributedString(string:"Your E-mail address (required)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userEmail.borderStyle = UITextField.BorderStyle.none
    }
    func setupUserPasswordField() {
        userPassword.placeholder = "Your account password!"
        userPassword.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPassword.borderStyle = UITextField.BorderStyle.none
        userPassword.isSecureTextEntry = true
    }
    func setupUserPasswordConfirmationField() {
        userPasswordConfirmation.placeholder = "Password confirmation!"
        userPasswordConfirmation.attributedPlaceholder = NSAttributedString(string:"Confirm your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPasswordConfirmation.borderStyle = UITextField.BorderStyle.none
        userPasswordConfirmation.isSecureTextEntry = true
        
    }
    func setupUserPhoneNumberField() {
        userPhoneNumber.attributedPlaceholder = NSAttributedString(string:"Your phone number (required)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        userPhoneNumber.borderStyle = UITextField.BorderStyle.none
    }
    func setupPhoneDisclamer() {
        phoneDisclamer.adjustsFontSizeToFitWidth = true
    }
    func setupSignUpButton() {
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = CG_Colors.red
        signupButton.backgroundColor = UI_Colors.red
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.showsTouchWhenHighlighted = true
        signupButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    func setupSignInButton() {
        signinButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
    }
  
    @objc func signUp(sender: UIButton!) {
        if testForVaildPhoneNumber() == true{
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPasswordConfirmation.text!) { (result, error) in
                if let errors = error {
                    if let errorcode = AuthErrorCode(rawValue: error!._code) {
                        switch errorcode {
                        case .invalidEmail:
                            self.simpleAlert(title: "Invalid email", msg: "Please be sure your formatting is correct")
                            print("invalid email")
                        case .emailAlreadyInUse:
                            self.simpleAlert(title: "Incorrect Email", msg: "This email is already in use!")
                        default:
                            print("Create User Error: \(error!)")
                        }
                    }
          
                } else {
                    let authUser = result!.user.uid
                    let email = self.userEmail.text
                    let name = self.userName.text
                    let phoneNumber = self.convertPhoneNumber(userPhoneNumber: self.userPhoneNumber)
                    let dbUser = User.init(email: email!, id: authUser, stripeId: "", name: name!, phoneNumber: phoneNumber)
                    self.createFireStoreUser(user: dbUser)
                    self.segueToHome()
                }
            }
        }
    }
    
    func createFireStoreUser (user: User) {
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        let data = User.modelToData(user: user)
        newUserRef.setData(data)
    }
    @objc func signInAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "toSignin", sender: self)
    }
    func settupFacebookButton() {
        let facebookButton =  FBLoginButton()
        facebookButton.delegate = self
        facebookButton.permissions = ["public_profile", "email"]
        view.addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        facebookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        facebookButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 15).isActive = true
        view.addSubview(facebookButton)
    }
//    func settupAppleLoginButton() {
//        let appleLoginButton = ASAuthorizationAppleIDButton()
//        appleLoginButton.center = view.center
//        appleLoginButton.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
//        view.addSubview(appleLoginButton)
//    }
//    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let nonce = randomNonceString()
//        request.nonce = sha256(nonce)
//        currentNonce = nonce
//
//        return request
//    }
//    @objc func handleSignInWithAppleTapped() {
//        startSignInWithAppleFlow()
//    }
//
//    private func randomNonceString(length: Int = 32) -> String {
//      precondition(length > 0)
//      let charset: Array<Character> =
//          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//      var result = ""
//      var remainingLength = length
//
//      while remainingLength > 0 {
//        let randoms: [UInt8] = (0 ..< 16).map { _ in
//          var random: UInt8 = 0
//          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//          if errorCode != errSecSuccess {
//            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
//          }
//          return random
//        }
//
//        randoms.forEach { random in
//          if remainingLength == 0 {
//            return
//          }
//
//          if random < charset.count {
//            result.append(charset[Int(random)])
//            remainingLength -= 1
//          }
//        }
//      }
//
//      return result
//    }

    // Unhashed nonce.
//    fileprivate var currentNonce: String?
//
//    @available(iOS 13, *)
//    func startSignInWithAppleFlow() {
//      let nonce = randomNonceString()
//      currentNonce = nonce
//      let appleIDProvider = ASAuthorizationAppleIDProvider()
//      let request = appleIDProvider.createRequest()
//      request.requestedScopes = [.fullName, .email]
//      request.nonce = sha256(nonce)
//
//      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//      authorizationController.delegate = self
//      authorizationController.presentationContextProvider = self
//      authorizationController.performRequests()
//    }
//
//    @available(iOS 13, *)
//    private func sha256(_ input: String) -> String {
//      let inputData = Data(input.utf8)
//      let hashedData = SHA256.hash(data: inputData)
//      let hashString = hashedData.compactMap {
//        return String(format: "%02x", $0)
//      }.joined()
//
//      return hashString
//    }
//}
}



extension signupPage: UITextFieldDelegate {
    func convertPhoneNumber(userPhoneNumber: UITextField) -> String {
        let acceptedPhoneNumber = userPhoneNumber.text!
        let phoneNumberForDB = "+1" + "\(acceptedPhoneNumber)"
        return(phoneNumberForDB)
    }
    func testForVaildPhoneNumber() -> Bool  {
        if userPhoneNumber.text?.count == 0 || userPhoneNumber.text!.count > 10 ||  userPhoneNumber.text!.count < 10 {
           simpleAlert(title: "Invalid Phone number", msg: "Your phone number has been incorrectly inputted. Make sure it is the full 10 digits")
            return (false)
        }
        return (true)
    }
}

//extension signupPage: ASAuthorizationControllerDelegate {
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//        guard let nonce = currentNonce else {
//          fatalError("Invalid state: A login callback was received, but no login request was sent.")
//        }
//        guard let appleIDToken = appleIDCredential.identityToken else {
//          print("Unable to fetch identity token")
//          return
//        }
//        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//          print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//          return
//        }
//        // Initialize a Firebase credential.
//        let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                  idToken: idTokenString,
//                                                  rawNonce: nonce)
//        // Sign in with Firebase.
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if (error != nil) {
//            // Error. If error.code == .MissingOrInvalidNonce, make sure
//            // you're sending the SHA256-hashed nonce as a hex string with
//            // your request to Apple.
//            print(error!.localizedDescription)
//            return
//          }
//          // User is signed in to Firebase with Apple.
//          // ...
//        }
//      }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//      // Handle error.
//      print("Sign in with Apple errored: \(error)")
//    }
//
//  }
//extension signupPage: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//
//
//}

