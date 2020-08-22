//
//  HeaderCelllTableViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 03/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class HeaderCelllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hollowView: UIView!
    @IBOutlet weak var dayOne: UIView!
    @IBOutlet weak var dayOneLbl: UILabel!
    
    @IBOutlet weak var dayTwo: UIView!
    @IBOutlet weak var dayTwoLbl: UILabel!
    
    @IBOutlet weak var dayThree: UIView!
    @IBOutlet weak var dayThreeLbl: UILabel!
    
    @IBOutlet weak var dayFour: UIView!
    @IBOutlet weak var dayFourLbl: UILabel!
    
    @IBOutlet weak var dayFive: UIView!
    @IBOutlet weak var dayFiveLbl: UILabel!
    
    @IBOutlet weak var daySix: UIView!
    @IBOutlet weak var daySixLbl: UILabel!
    
    @IBOutlet weak var daySeven: UIView!
    @IBOutlet weak var daySevenLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
