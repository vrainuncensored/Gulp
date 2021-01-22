//
//  MenuItems.swift
//  gulp
//
//  Created by Vrain Ahuja on 4/8/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit

class MenuItems: UITableViewCell {
    
    var itemLabel = UILabel()
    var priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(itemLabel)
        addSubview(priceLabel)
        
        configurePriceLabel()
        configureTitleLabel()
        setItemConstraints()
        setPriceConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: MenuItem) {
        itemLabel.text = item.name
        let price = String(item.price)
        if price.count == 3 {
        priceLabel.text = "$" + price + "0"
        }
        if price.count == 4 {
            priceLabel.text = "$" + price
        }
        
    }
    func configureTitleLabel(){
        itemLabel.numberOfLines = 0
        itemLabel.adjustsFontSizeToFitWidth = true
        itemLabel.font = UIFont(name: "AvenirNext-Bold" , size: 17.0)
        itemLabel.textColor = UIColor.black

    }
    func configurePriceLabel(){
        priceLabel.numberOfLines = 0
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.font = UIFont(name: "AvenirNext-Bold" , size: 17.0)
        priceLabel.textColor = UIColor.black
    }
    
    func setItemConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        itemLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -40).isActive = true
    }
    func setPriceConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
    }
}
