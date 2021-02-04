//
//  HomeTabController.swift
//  gulp
//
//  Created by vrain ahuja on 2/2/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class HomeTabController: UITabBarController {
    var customTabItem = UITabBarItem()
    let tabConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupOrdersIcon()
        settupShopIcon()
        //settupAccountIcon()
     
        // Do any additional setup after loading the view.
    }
    func settupShopIcon() {
        let defaultShopIcon = "bag"
        let shopLabel = "Shop"
        let shop = UIImage(systemName: defaultShopIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![0]
        customTabItem.title = shopLabel
        customTabItem.image = shop
    }
    func settupOrdersIcon() {
        let defaultOrdersIcon = "scroll"
        let orderLabel = "Orders"
        let orders = UIImage(systemName: defaultOrdersIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![1]
        customTabItem.title = orderLabel
        customTabItem.image = orders
    }
    func settupAccountIcon(){
        let defaultAccountIcon = "person"
        let accountLabel = "Account"
        let account = UIImage(systemName: defaultAccountIcon , withConfiguration: tabConfig )
        customTabItem = self.tabBar.items![2]
        customTabItem.title = accountLabel
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
