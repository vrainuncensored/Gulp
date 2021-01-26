//
//  MenuTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 1/25/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(item: MenuItem) {
        itemName.text = item.name
        itemDescription.text = item.description
        let price = String(item.price)
        if price.count == 3 {
        itemPrice.text = "$" + price + "0"
        }
        if price.count == 4 {
            itemPrice.text = "$" + price
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
