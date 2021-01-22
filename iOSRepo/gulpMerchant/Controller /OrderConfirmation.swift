//
//  OrderConfirmation.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 1/21/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class OrderConfirmation: UIViewController {
    //Button Outlets
    @IBOutlet weak var confirmationButton: UIButton!
    
    //Label Outlets
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfirmationButton()
        setupOrderNumberLabel()
        // Do any additional setup after loading the view.
    }
    @objc func notify() {
        cloudFunctions.orderAcceptedNotification()
    }
    func setupOrderNumberLabel() {
        orderNumberLabel.text = "Order Number  " + String(565)
    }
    func setupConfirmationButton() {
        confirmationButton.setTitle("Confirm Order", for: .normal)
        confirmationButton.showsTouchWhenHighlighted = true
        confirmationButton.layer.cornerRadius = 5
        confirmationButton.layer.borderWidth = 1
        confirmationButton.layer.borderColor = CG_Colors.red
        confirmationButton.backgroundColor = UI_Colors.red
        confirmationButton.addTarget(self, action: #selector(notify), for: .touchUpInside)
        confirmationButton.setTitleColor(.white, for: .normal)
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
