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
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(truck: Truck) {
        truckName.text = truck.name
        truckCuisine.text = truck.cuisine
        distanceLabel.text = String(format: "%.3f", truck.disTance)
//
        if truck.companyLogoURL == nil {
            let link = URL(string: "https://firebasestorage.googleapis.com/v0/b/ordergulp.appspot.com/o/gulplogo.png?alt=media&token=b3f2fb56-46e2-4a17-93b9-f617c97b4f99")
            productImage.kf.setImage(with: link)
        } else {
            let url = URL(string: truck.companyLogoURL!)
           productImage.kf.setImage(with: url)
            print("It's working")
        }
        
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
