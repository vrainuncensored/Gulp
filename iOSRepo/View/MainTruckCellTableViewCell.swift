//
//  MainTruckCellTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 1/25/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Kingfisher

class MainTruckCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var truckCuisine: UILabel!
    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/ordergulp.appspot.com/o/Fernando%E2%80%99s%20Cropped.jpg?alt=media&token=1cafce4c-827c-4c87-bb84-2443b6af25eb")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(truck: Truck) {
        truckName.text = truck.name
        truckCuisine.text = truck.cuisine
        productImage.kf.setImage(with: url)
//        productImage.layer.borderWidth = 1.5
//        productImage.layer.borderColor = CG_Colors.lightPurple
//        productImage.layer.cornerRadius = 30.0
        view.layer.borderWidth = 2.5
        view.layer.borderColor = CG_Colors.red
        view.layer.cornerRadius = 20.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
