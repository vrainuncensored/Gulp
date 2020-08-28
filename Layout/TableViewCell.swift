//
//  TableViewCell.swift
//  gulp
//
//  Created by Vrain Ahuja on 7/7/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import UIKit
protocol CartItemCheckoutCellDelegate : class {
    func deleteItem(item: CartItem)
}
class CartItemCheckout: UITableViewCell {
    
    var itemLabel = UILabel()
    var priceLabel = UILabel()
    var deleteButton = UIButton()
    weak var delegate : CartItemCheckoutCellDelegate?
    private var productItem : CartItem!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(itemLabel)
        addSubview(priceLabel)
        addSubview(deleteButton)
        
        configurePriceLabel()
        configureTitleLabel()
        configureEditLabel()
        setItemConstraints()
        setPriceConstraints()
        setEditConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: CartItem , delegate: CartItemCheckoutCellDelegate) {
        itemLabel.text = item.item.name
        priceLabel.text = String(item.subTotal)
        self.productItem = item
        self.delegate = delegate
    }

    @objc func deleteItemClicked(_ sender: Any){
        delegate?.deleteItem(item: productItem)
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
    func configureEditLabel(){
        let userLogo = "minus.circle.fill"
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .medium)
        let userImage = UIImage(systemName: userLogo, withConfiguration: buttonConfig)
        deleteButton.setBackgroundImage(userImage, for: .normal)
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
        priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 40).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -40).isActive = true
    }
    func setEditConstraints() {
           deleteButton.translatesAutoresizingMaskIntoConstraints = false
           deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           deleteButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 30).isActive = true
           //deleteButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
           deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        deleteButton.addTarget(self, action: #selector(deleteItemClicked), for: .touchUpInside)
       }
}

