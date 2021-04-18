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
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var dollarBillLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(truck: Truck) {
        truckName.text = truck.name
        truckCuisine.text = truck.cuisine
        distanceLabel.text = String(format: "%.1f", truck.disTance) + " mi"
        starsLabel.text = "⭐️ 4.5"
        dollarBillLabel.text = "$$"
        configureDistanceLabel()
        configureTitleLabel()
        configureBillLabel()
        configureCusineLabel()
        configureStarsLabel()
        if truck.companyLogoURL == nil {
            let link = URL(string: "https://firebasestorage.googleapis.com/v0/b/ordergulp.appspot.com/o/gulplogo.png?alt=media&token=b3f2fb56-46e2-4a17-93b9-f617c97b4f99")
            productImage.kf.setImage(with: link)
        } else {
            let url = URL(string: truck.companyLogoURL!)
           productImage.kf.setImage(with: url)
        }
        
//        productImage.layer.borderWidth = 1.5
//        productImage.layer.borderColor = CG_Colors.lightPurple
//        productImage.layer.cornerRadius = 30.0
//        view.layer.borderWidth = 2.5
//        view.layer.borderColor = CG_Colors.red
        view.layer.cornerRadius = 4
        view.backgroundColor = UI_Colors.white
        view.layer.masksToBounds = false
        //view.layer.shadowOffset = CGSize(width: 0, height: 20)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.75
        view.layer.shadowRadius = 4.0
        
    }
    func configureDistanceLabel(){
        distanceLabel.adjustsFontSizeToFitWidth = true
        distanceLabel.font = UIFont(name: "AvenirNext-Medium" , size: 14.0)
        distanceLabel.textColor = UI_Colors.red

    }
    func configureTitleLabel(){
        truckName.adjustsFontSizeToFitWidth = true
        truckName.font = UIFont(name: "Righteous" , size: 22.0)
        truckName.textColor = UI_Colors.black
    }
    func configureBillLabel() {
        dollarBillLabel.adjustsFontSizeToFitWidth = true
        dollarBillLabel.font = UIFont(name: "AvenirNext-Regular" , size: 14.0)
        dollarBillLabel.textColor = UI_Colors.grey
    }
    func configureCusineLabel() {
        truckCuisine.adjustsFontSizeToFitWidth = true
        truckCuisine.font = UIFont(name: "AvenirNext-Regular" , size: 14.0)
        truckCuisine.textColor = UI_Colors.grey
    }
    func configureStarsLabel() {
        starsLabel.adjustsFontSizeToFitWidth = true
        starsLabel.font = UIFont(name: "AvenirNext-Regular" , size: 14.0)
        starsLabel.textColor = UI_Colors.grey
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
