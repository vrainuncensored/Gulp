//
//  CustomTabBar.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 5/2/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    var customTabItem = UITabBarItem()
    
    override func viewDidLoad() {
    //Settup Tab Bar Styling
    settupTabStyling()
    //Settup Individual Tab Bar Items
    settupOrderTabItem()
    settupLocationTabItem()
    settupAccountTabItem()
 
        // Do any additional setup after loading the view.
    }
    func settupTabStyling() {
        UITabBar.appearance().tintColor = UI_Colors.red
        UITabBar.appearance().barTintColor = UI_Colors.white
        UITabBarItem.appearance().setTitleTextAttributes(tabFontAttributes as [NSAttributedString.Key : Any], for: .normal)
    }
    func settupOrderTabItem() {
        let orders = UIImage(systemName: tabIcons.ordersIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![0]
        customTabItem.title = tabLabels.orderLabel
        customTabItem.image = orders
    }
    func settupLocationTabItem() {
        let location = UIImage(systemName: tabIcons.locationIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![1]
        customTabItem.title = tabLabels.locationLabel
        customTabItem.image = location
    }
    func settupAccountTabItem() {
        let account = UIImage(systemName: tabIcons.accountIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![2]
        customTabItem.title = tabLabels.accountLabel
        customTabItem.image = account
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
