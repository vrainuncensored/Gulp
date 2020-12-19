//
//  navigation bar.swift
//  gulp
//
//  Created by Vrain Ahuja on 5/24/20.
//  Copyright © 2020 Gulp. All rights reserved.
//
import UIKit

extension UIViewController {
   func viewWillLayoutSubviews() {
      let width = self.view.frame.width
      let height = self.view.frame.height
      let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 350))
    view.addSubview(navigationBar)
        
    
   let navItem = UINavigationItem()
   let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(selectorX))
    navItem.rightBarButtonItem = doneItem

    navigationBar.setItems([navItem], animated: true)
   }
   
   @objc func selectorX() {
    print("hello world")
    }
}
class NavigationBarTitleView: UIView {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width - 100, height: 50)
    }

}
