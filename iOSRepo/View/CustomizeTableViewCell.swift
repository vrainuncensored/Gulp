//
//  CustomizeTableViewCell.swift
//  gulp
//
//  Created by vrain ahuja on 1/26/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit

class CustomizeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sideLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(item: String) {
    sideLabel.text = item
    }
    
}
