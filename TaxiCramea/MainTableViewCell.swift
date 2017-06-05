//
//  MainTableViewCell.swift
//  TaxiCramea
//
//  Created by Alexey Sinitsa on 31.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var whereLabel: UILabel!
    
    @IBOutlet weak var whenceLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
