//
//  DropDownListCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 22/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class DropDownListCell: UITableViewCell {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 12.0
        parentView.layer.masksToBounds = true
        parentView.layer.cornerRadius = 12.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
