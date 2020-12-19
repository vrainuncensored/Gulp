//
//  ordersTableViewCell.swift
//  gulpMerchant
//
//  Created by Vrain Ahuja on 7/15/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class ordersTableViewCell: UITableViewCell {

    var orderNumber = UILabel()
    var customerName = UILabel()
    var orderdItems = UILabel()

           override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
               super.init(style: style, reuseIdentifier: reuseIdentifier)
               addSubview(orderNumber)
               addSubview(customerName)
               addSubview(orderdItems)
               
               configurePriceLabel()
               configureTitleLabel()
               setItemConstraints()
               setPriceConstraints()
           }
           
           required init?(coder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
           }
           
           func set(item: Order) {
            orderNumber.text = item.orderNumber
            customerName.text = item.customerName
               
           }
           func configureTitleLabel(){
               orderNumber.numberOfLines = 0
               orderNumber.adjustsFontSizeToFitWidth = true
               orderNumber.font = UIFont(name: "AvenirNext-Bold" , size: 17.0)
               orderNumber.textColor = UIColor.black

           }
           func configurePriceLabel(){
               customerName.numberOfLines = 0
               customerName.adjustsFontSizeToFitWidth = true
               customerName.font = UIFont(name: "AvenirNext-Bold" , size: 17.0)
               customerName.textColor = UIColor.black
           }
           
           func setItemConstraints() {
               orderNumber.translatesAutoresizingMaskIntoConstraints = false
               orderNumber.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
               orderNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
               orderNumber.heightAnchor.constraint(equalToConstant: 25).isActive = true
               orderNumber.trailingAnchor.constraint(equalTo: customerName.leadingAnchor, constant: -40).isActive = true
           }
           func setPriceConstraints() {
               customerName.translatesAutoresizingMaskIntoConstraints = false
               customerName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
               customerName.leadingAnchor.constraint(equalTo: orderNumber.trailingAnchor, constant: 10).isActive = true
               customerName.heightAnchor.constraint(equalToConstant: 25).isActive = true
               customerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
           }
       }
