//
//  MainTruckCellTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 1/25/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class MainTruckCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var truckCuisine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(truck: Truck) {
        truckName.text = truck.name
        truckCuisine.text = truck.name
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
