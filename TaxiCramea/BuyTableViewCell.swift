//
//  BuyTableViewCell.swift
//  TaxiCramea
//
//  Created by админ on 28.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit

class BuyTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTextFild: UILabel!
    
    @IBOutlet weak var time1TextFild: UILabel!
    
    @IBOutlet weak var time2TextFild: UILabel!
    
    @IBOutlet weak var whereTextFild: UILabel!
    
    @IBOutlet weak var whenceTextFild: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
