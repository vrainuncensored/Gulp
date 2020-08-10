//
//  paymentHistory.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/4/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
import MapKit

class ManageLocation: UIViewController {
    //map outlets
    @IBOutlet weak var truckLocation: MKMapView!
    
    //button outlets
    
    @IBOutlet weak var updateLocationButton: UIButton!
    @IBOutlet weak var closedButton: UIButton!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Manage Your Location"
        super.viewDidLoad()
        setupUpdateButton()
        setupClosedButton()
        // Do any additional setup after loading the view.
    }
    func setupUpdateButton() {
        updateLocationButton.layer.cornerRadius = 5
        updateLocationButton.layer.borderWidth = 1
        updateLocationButton.layer.borderColor = CG_Colors.darkPurple
        updateLocationButton.backgroundColor = UI_Colors.darkPurple
        updateLocationButton.setTitle("Update Location", for: .normal)
        updateLocationButton.showsTouchWhenHighlighted = true
        //updateLocation.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
    }
    func setupClosedButton() {
           closedButton.layer.cornerRadius = 5
           closedButton.layer.borderWidth = 1
           closedButton.layer.borderColor = CG_Colors.darkPurple
           closedButton.backgroundColor = UI_Colors.darkPurple
           closedButton.setTitle("Closed", for: .normal)
           closedButton.showsTouchWhenHighlighted = true
           //updateLocation.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
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
