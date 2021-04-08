//
//  OrderBreakdownTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 4/2/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class OrderBreakdownTableViewCell: UITableViewCell {

    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(order: Order) {
        orderQuantity.text = String(order.items.count)
        xLabel.text = "X"
    itemDescription.text = order.customerName
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
