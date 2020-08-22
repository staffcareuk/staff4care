//
//  HolidayCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class HolidayCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var holidayIcon: UIImageView!
    @IBOutlet weak var holidayLabel: UILabel!
    @IBOutlet weak var dateRangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentView.layer.masksToBounds = true
        self.parentView.layer.cornerRadius = 12.0
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
