//
//  AvailabityCell.swift
//  Staff4Care
//
//  Created by Asad Khan on 02/09/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

protocol AvailabityCellDelegate: class {
    func availabityBtnClicked(_ shiftId: Int)
}

class AvailabityCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tueBtn: UIButton!
    @IBOutlet weak var wedBtn: UIButton!
    
    @IBOutlet weak var thuBtn: UIButton!
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var friBtn: UIButton!
    @IBOutlet weak var satBtn: UIButton!
    @IBOutlet weak var sunBtn: UIButton!
    
    weak var delegate: AvailabityCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func monBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(mondayBtn.tag)
    }
    @IBAction func tueBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(tueBtn.tag)
    }
    
    @IBAction func wedBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(wedBtn.tag)
    }
    @IBAction func thuBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(thuBtn.tag)
    }
    @IBAction func friBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(friBtn.tag)
    }
    
    @IBAction func satBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(satBtn.tag)
    }
    @IBAction func sunBtnClicked(_ sender: Any) {
        delegate?.availabityBtnClicked(sunBtn.tag)
    }
    
}
