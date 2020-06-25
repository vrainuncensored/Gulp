//
//  userCartVC.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import Stripe

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
        
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
    }
    
    
}
