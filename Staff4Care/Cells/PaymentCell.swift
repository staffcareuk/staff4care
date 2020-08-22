//
//  PaymentCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clinetImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountStatusIcon: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
        self.parentView.layer.masksToBounds = true
        self.parentView.layer.cornerRadius = 12.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
