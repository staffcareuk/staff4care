//
//  ViewJobsTableViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
protocol JobsButtonsTapped  {
  func seeJobTapped()
  func applyJobTapped()
  func expireJobTapped()
}
class ViewJobsTableViewCell: UITableViewCell {

    
    // MARK:- IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clientImage: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var jobRoleLbl: UILabel!
    @IBOutlet weak var clientRole: UILabel!
    @IBOutlet weak var shifTimeLbl: UILabel!
    @IBOutlet weak var seeJobBtn: CustomButton!
    @IBOutlet weak var applyJobBtn: CustomButton!
    @IBOutlet weak var expireJobBtn: CustomButton!
    
    // MARK:- Variables
    var buttonTapDelegate : JobsButtonsTapped?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seeJobBtn.setup(applyGradient: true,title: "See Job",rgb1: (154,154,198),rgb2: (39,65,143))
        applyJobBtn.setup(applyGradient: true,title: "Apply Job",rgb1: (192,221,184),rgb2: (174,200,55))

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Cell Configure Methods
    func configureCell(job: JobsList) {
        self.clientImage.image = UIImage(named: "generic-hospital")
        self.clientName.text   = job.hospitalName
        self.clientRole.text   = job.contactDesignation
        if let from = job.jobFrom , let to = job.jobTo , let date = job.jobDate{
            self.shifTimeLbl.text  = from + " - " + to + " Hrs | " + date
        }
    }
    
    
    // MARK:- IBAction Methods
    
    @IBAction func seejobsButtonTapped(_ sender: Any) {
        buttonTapDelegate?.seeJobTapped()
        
    }
    @IBAction func applyjobsButtonTapped(_ sender: Any) {
        buttonTapDelegate?.applyJobTapped()

    }
    @IBAction func expirejobsButtonTapped(_ sender: Any) {
        buttonTapDelegate?.expireJobTapped()
    }
    
    
    
}
