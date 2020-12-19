//
//  MenuItemsButton.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/11/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class MenuItemsButton: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        func menuButtons (placeHolderText: String) {
               itemName.textColor = UIColor.red
               itemName.frame = CGRect(x:  0, y: 100, width: width * 5/6, height: height * 1/10)
               itemName.autocapitalizationType = UITextAutocapitalizationType.none
               itemName.placeholder = placeHolderText
               itemName.layer.cornerRadius = 5
               itemName.layer.borderWidth = 1
               self.view.addSubview(itemName)
               super.viewDidLoad()
               
           }
        // Do any additional setup after loading the view.
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
