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
   var truckImage = UIImageView()
   var truckCategory = UILabel()


        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(truckName)
           // addSubview(menuButton)
            addSubview(truckImage)
            addSubview(truckCategory)
            
            configureTruckLabel()
            setTruckConstraints()
            configureTruckImage()
            setTruckImageConstraints()
            configureTruckCategoryLabel()
            setTruckCategoryConstraints()
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
            truckName.font = UIFont(name: "AvenirNext-Bold" , size: 17.0)
            truckName.textColor = UIColor.black
        }
    func configureTruckCategoryLabel(){
        truckCategory.numberOfLines = 0
        truckCategory.adjustsFontSizeToFitWidth = true
        truckCategory.font = UIFont(name: "AvenirNext-Bold" , size: 13.0)
        truckCategory.textColor = UIColor.black
        truckCategory.text = "hello"
    }
    
    func configureTruckImage() {
        let placeholder = UIImage(named: "gulplogo")
        truckImage.image = placeholder
        truckImage.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        truckImage.translatesAutoresizingMaskIntoConstraints = false
        truckImage.layer.cornerRadius = 13
        truckImage.clipsToBounds = true
    }
    
        
        func setTruckConstraints() {
            truckName.translatesAutoresizingMaskIntoConstraints = false
            truckName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            truckName.leadingAnchor.constraint(equalTo: truckImage.trailingAnchor, constant: 15).isActive = true
            truckName.heightAnchor.constraint(equalToConstant: 25).isActive = true
            truckName.trailingAnchor.constraint(equalTo: trailingAnchor, constant:30).isActive = true
        }
    func setTruckImageConstraints() {
        truckImage.translatesAutoresizingMaskIntoConstraints = false
        //truckImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        truckImage.trailingAnchor.constraint(equalTo: truckName.leadingAnchor, constant: -15).isActive = true
        truckImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
        truckImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        truckImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        truckImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        truckImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    func setTruckCategoryConstraints() {
        truckCategory.topAnchor.constraint(equalTo: truckName.bottomAnchor, constant: 10).isActive = true
        truckCategory.translatesAutoresizingMaskIntoConstraints = false
    }
//    func setButtonConstraints() {
//        menuButton.translatesAutoresizingMaskIntoConstraints = false
//        menuButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
//        menuButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
//    }
   
        
    }
