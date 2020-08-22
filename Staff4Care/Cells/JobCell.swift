//
//  NearbyClientsCollectionViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class JobCell: UICollectionViewCell {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clientImage: ImageFromSource!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var jobRole: UILabel!
    @IBOutlet weak var clientRole: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
          }
          required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
          }
       func configureCell(job: JobsList) {
           self.parentView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)
//           if let imageUrl = category.categoryImage{
//               self.clientImage.contentMode = .scaleAspectFill
//               self.clientImage.loadImageUsingUrlString(imageUrl: imageUrl,resize: true,targetSize: CGSize(width: 62, height: 62))
//           }
       self.clientName.text   = job.hospitalName
       self.clientRole.text   = job.contactDesignation
        self.jobRole.text     = "Staff Care"
       if let from = job.jobFrom , let to = job.jobTo , let date = job.jobDate{
           self.availabilityLabel.text  = from + " - " + to + " Hrs | " + date
       }
       }
     func configureCellforStaff(staff: StaffList) {
               self.parentView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)
        self.clientName.text   = staff.name
        self.clientRole.text   = staff.designation
        self.jobRole.text     = staff.company

           }
    
}
