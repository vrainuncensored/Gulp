//
//  userCartVC.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Stripe
import FirebaseFunctions

class userCartVC: UIViewController {
var paymentContext: STPPaymentContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStripeConfig()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let array : [CartItem] = shoppingCart.items
        print(array[0].item.name)
        let label = UILabel()
            label.text = "Confirm Checkout"

        let imageViewBackground = UIButton(frame: CGRect(x:  0, y: 0, width: width/4, height: height/4))
        //    imageViewBackground.setImage(image, for: .normal)
        // you can change the content mode:
        imageViewBackground.setTitle("Confirm Checkout", for: .normal)
        imageViewBackground.setTitleColor(UIColor.blue, for: .normal)
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewBackground.alpha = 1
        imageViewBackground.addTarget(self, action: #selector(stripeAction), for: .touchUpInside)
        
        
        let checkout = UIButton(frame: CGRect(x:  0, y: 200, width: width/4, height: height/4))
               //    imageViewBackground.setImage(image, for: .normal)
               // you can change the content mode:
               checkout.setTitle("Confirm Checkout", for: .normal)
               checkout.setTitleColor(UIColor.blue, for: .normal)
               checkout.contentMode = UIView.ContentMode.scaleAspectFill
               checkout.alpha = 1
               checkout.addTarget(self, action: #selector(stripeCheckout), for: .touchUpInside)
        
        
        self.view.addSubview(checkout)
        self.view.addSubview(imageViewBackground)
        
        
//        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
//        imageViewBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        imageViewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        imageViewBackground.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        imageViewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        
        
        
        
       
        

        // Do any additional setup after loading the view.
    }
    func setupStripeConfig(){
               let config = STPPaymentConfiguration.shared()
               config.companyName = "Gulp"
               config.requiredBillingAddressFields = .none
               config.requiredShippingAddressFields = .none
               //config.createCardSources = true
               
               
               let customerContext = STPCustomerContext(keyProvider: StripeApi)
               paymentContext = STPPaymentContext(customerContext: customerContext, configuration: config, theme: .default())
               paymentContext.delegate = self
               paymentContext.hostViewController = self
           }
    @objc func stripeAction() {
        paymentContext.presentPaymentOptionsViewController()
        
    }
    @objc func stripeCheckout() {
        paymentContext.requestPayment()
        
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

extension userCartVC : STPPaymentContextDelegate {
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        //activityIndicator.stopAnimating()
            
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            let retry = UIAlertAction(title: "Retry", style: .default) { (action) in
                self.paymentContext.retryLoading()
            }
            
        alertController.addAction(cancel)
        alertController.addAction(retry)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        let idempotency = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        
        let data : [String : Any] = [
            "total" : 5000,
            "customerId" : userservice.user.stripeId,
            "payment_method_id" : paymentResult.paymentMethod?.stripeId,
            "idempotency" : idempotency
        ]
        
        Functions.functions().httpsCallable("makeCharge").call(data) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", msg: "Unable to make charge.")
                completion(STPPaymentStatus.error, error)
                return
            }
            shoppingCart.clearCart()
            completion(.success, nil)
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        let title: String
        let message: String
        
        switch status {
        case .error:
            title = "Error"
            //without the ??, this is a optional string value( string?), so that it must be unwrapped by doing a "nill coalissing", which is adding to question marks. This is a saftey guard in the case that the optional is in fact empty. It will give the value of empty just in case
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success!"
            message = "Thank you for your purchase!"
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true,completion: nil)
    }
    
    
}
