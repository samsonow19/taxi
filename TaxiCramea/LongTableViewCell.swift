//
//  LongTableViewCell.swift
//  TaxiCramea
//
//  Created by Alexey Sinitsa on 31.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit

class LongTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var whereLabel: UILabel!
    
    @IBOutlet weak var whenceLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var testInfo: NSLayoutConstraint! // 497
    
    @IBOutlet weak var komissionLabel: UILabel!
   
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var plainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var yourLabel: UILabel!
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var testConstr: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    var hide: Bool = false

    @IBAction func showHide(_ sender: Any) {
        
        if hide == true {
            infoView.isHidden = true
            testInfo.constant = 0
            hide = false
        } else {
            infoView.isHidden = false
            testInfo.constant = 497
            hide = true
        }
    }
    override func awakeFromNib() {
        infoView.isHidden = true
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
