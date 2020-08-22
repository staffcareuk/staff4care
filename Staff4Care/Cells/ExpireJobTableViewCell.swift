//
//  ExpireJobTableViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class ExpireJobTableViewCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clientImage: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var jobRoleLbl: UILabel!
    @IBOutlet weak var clientRoleLbl: UILabel!
    @IBOutlet weak var shiftLbl: UILabel!
    @IBOutlet weak var expireJobBtn: CustomButton!
    
    
    
    
    // MARK:- Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func expireJobPressed(_ sender: Any) {
    }
    
}
