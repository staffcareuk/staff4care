//
//  TravelHistoryCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class TravelHistoryCell: UITableViewCell {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clientImage: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountStatusIcon: UIImageView!
    
    @IBOutlet weak var milesIcon: UIImageView!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var milesStack: UIStackView!
    @IBOutlet weak var amountStack: UIStackView!
    @IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
