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
    
//Buttons Outlets
    @IBOutlet weak var paymentMethodBtn: UIButton!
    @IBOutlet weak var placeOrderBtn: UIButton!
//Label Outlets
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var taxTotalLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
//TableView Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    var paymentContext: STPPaymentContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStripeConfig()
        self.navigationItem.title = "Checkout"
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let array : [CartItem] = shoppingCart.items
        print(array[0].item.name)
        let label = UILabel()
        label.text = "Confirm Checkout"
        
       
        setupPaymentInfo()
        setupTableView()
        paymentMethodBtn.addTarget(self, action: #selector(stripeAction), for: .touchUpInside)
        
        
       
        placeOrderBtn.addTarget(self, action: #selector(stripeCheckout), for: .touchUpInside)
        placeOrderBtn.layer.borderWidth = 2
        placeOrderBtn.layer.borderColor = CG_Colors.darkPurple
        placeOrderBtn.backgroundColor = UI_Colors.darkPurple
        
        
        
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
    func setupPaymentInfo() {
        subTotalLbl.text = shoppingCart.subtotal.penniesToFormattedCurrency()
        taxTotalLbl.text = shoppingCart.tax.penniesToFormattedCurrency()
        totalLbl.text = shoppingCart.totalCost.penniesToFormattedCurrency()
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemCheckout.self, forCellReuseIdentifier: "Test")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
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
        if let paymentMethod = paymentContext.selectedPaymentOption {
            paymentMethodBtn.setTitle(paymentMethod.label, for: .normal)
        } else {
            paymentMethodBtn.setTitle("Select Method", for: .normal)
        }
            }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        let idempotency = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        
        let data : [String : Any] = [
            "total" : shoppingCart.totalCost,
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
extension userCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return( shoppingCart.items.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! CartItemCheckout
        let item = shoppingCart.items[indexPath.row]
        
        cell.set(item: item)
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = CG_Colors.lightPurple
        cell.layer.cornerRadius = 30.0
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
           return false
    }
      
    
}

