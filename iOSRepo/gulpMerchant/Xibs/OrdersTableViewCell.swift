//
//  OrdersTableViewCell.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 3/30/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemBreakdown: UITextView!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var Status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(order: Order) {
        orderNumber.text = "Order: " + order.orderNumber
        itemCount.text = String(order.items.count) + " items"
        let timeFromServer = order.timestamp.dateValue()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let formattedDateInString = formatter.string(from: timeFromServer)
        time.text = "Time: " + formattedDateInString
        Status.backgroundColor = UI_Colors.red
        Status.text = order.status
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
