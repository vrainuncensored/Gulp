//
//  PastOrderTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 2/3/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class PastOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var TruckNameLabel: UILabel!
    @IBOutlet weak var QuantityLabel: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var MenuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        settupQuantityLabel()
        settupPriceLabel()
        settupDateLabel()
        settupStatusLabel()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func settupQuantityLabel(){
        QuantityLabel.numberOfLines = 0
        QuantityLabel.adjustsFontSizeToFitWidth = true
        QuantityLabel.font = UIFont(name: "AvenirNext-Bold" , size: 14.0)
        QuantityLabel.textColor = UIColor.black
    }
    func settupPriceLabel(){
        PriceLabel.numberOfLines = 0
        PriceLabel.adjustsFontSizeToFitWidth = true
        PriceLabel.font = UIFont(name: "AvenirNext-Bold" , size: 14.0)
        PriceLabel.textColor = UIColor.black
    }
    func settupDateLabel() {
        DateLabel.numberOfLines = 0
        DateLabel.adjustsFontSizeToFitWidth = true
        DateLabel.font = UIFont(name: "AvenirNext-Bold" , size: 14.0)
        DateLabel.textColor = UIColor.black
    }
    func settupStatusLabel() {
        StatusLabel.numberOfLines = 0
        StatusLabel.adjustsFontSizeToFitWidth = true
        StatusLabel.font = UIFont(name: "AvenirNext-Bold" , size: 14.0)
        StatusLabel.textColor = UIColor.black
    }
    
}
