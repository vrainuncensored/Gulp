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
    let defaultOrdersIcon = "tray.and.arrow.down"
    let defaulutMenuIcon = "table.badge.more"
    let defaultLocationIcon = "location.circle"
    let orderLabel = "Orders"
    let menuLabel = "Menu Items"
    let tabConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
    
    override func viewDidLoad() {
    let orders = UIImage(systemName: defaultOrdersIcon , withConfiguration: tabConfig )
    let menu = UIImage(systemName: defaulutMenuIcon, withConfiguration: tabConfig)
    let location = UIImage(systemName: defaultLocationIcon, withConfiguration: tabConfig)

        customTabItem = self.tabBar.items![0]
        customTabItem.title = orderLabel
        customTabItem.image = orders
    
        
        customTabItem = self.tabBar.items![1]
        customTabItem.image = menu
        customTabItem.title = menuLabel
        
        customTabItem = self.tabBar.items![2]
        customTabItem.image = location
        customTabItem.title = "Location"


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
