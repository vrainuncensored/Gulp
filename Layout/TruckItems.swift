//
//  TruckItems.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/20/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class TruckItems: UITableViewCell {

   var truckName = UILabel()
    //var menuButton = UIButton()
  

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(truckName)
           // addSubview(menuButton)
            
            configureTruckLabel()
            setTruckConstraints()
           // setButtonConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func set(item: Truck) {
            truckName.text = item.name
            
        }
        func configureTruckLabel(){
            truckName.numberOfLines = 0
            truckName.adjustsFontSizeToFitWidth = true
        }
        
        func setTruckConstraints() {
            truckName.translatesAutoresizingMaskIntoConstraints = false
            truckName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            truckName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            truckName.heightAnchor.constraint(equalToConstant: 25).isActive = true
            truckName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        }
//    func setButtonConstraints() {
//        menuButton.translatesAutoresizingMaskIntoConstraints = false
//        menuButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
//        menuButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
//    }
   
        
    }
