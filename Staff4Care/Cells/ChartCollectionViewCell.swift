//
//  ChartCollectionViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 03/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
protocol AvailabilityChanged {
    func isAvailableStatus(available: Bool)
}

class ChartCollectionViewCell: UICollectionViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var shiftLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var availabilityBtn: UIButton!
    @IBOutlet weak var parentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var parentViewHeight: NSLayoutConstraint!
    
    var isAvailable = false
    var availabilityDelegate: AvailabilityChanged?
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    @IBAction func availabilityButtonTapped(_ sender: UIButton) {
         if isAvailable{

             isAvailable = false
            sender.setImage(UIImage(named: "ic_tick"), for: .normal)
         }
         else{

             isAvailable = true
            sender.setImage(UIImage(named: "ic_cross"), for: .normal)
         }
        availabilityDelegate?.isAvailableStatus(available: isAvailable)
    }
    
}
