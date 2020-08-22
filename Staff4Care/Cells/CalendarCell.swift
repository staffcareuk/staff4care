//
//  CalendarCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 05/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {
    // MARK:- IB Outlets
    

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    
    
    
    
    //MARK:- Variables
    
    
    
    
    
    
    // MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
        self.parentView.layer.masksToBounds = true
        self.parentView.layer.cornerRadius = 12.0
        self.parentView.layer.applyShadow()
        self.layer.applyShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
