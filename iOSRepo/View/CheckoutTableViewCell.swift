//
//  CheckoutTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 2/2/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var ItemNameLabel: UILabel!
    
    @IBOutlet weak var AddOnsLabel: UILabel!
    @IBOutlet weak var ItemPriceLabel: UILabel!
    @IBOutlet weak var AddOnPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(item:CartItem) {
        QuantityLabel.text = String(item.quantity)
        ItemNameLabel.text = item.item.name
        AddOnsLabel.text = item.item.description
        ItemPriceLabel.text = String(item.subTotal)
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
