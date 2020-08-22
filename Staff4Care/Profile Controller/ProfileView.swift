//
//  ProfileView.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 29/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
class ProfileView: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var summaryTitleLbl: UILabel!
    @IBOutlet weak var registeredLbl: UILabel!
    @IBOutlet weak var specialExpLbl: UILabel!
    @IBOutlet weak var firstAidLbl: UILabel!
    @IBOutlet weak var dbsLbl: UILabel!
    
    @IBOutlet weak var careerQualificationLbl: UILabel!
    @IBOutlet weak var carehomeExpLbl: UILabel!
    
    @IBOutlet weak var summaryContainerView: UIView!
    @IBOutlet weak var summaryContainerViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var aboutTitleLbl: UILabel!
    @IBOutlet weak var aboutDescriptionLbl: DynamicLabel!
    @IBOutlet weak var aboutContainerViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var experienceContainerView: UIView!
    @IBOutlet weak var experienceTitleLbl: UILabel!
    @IBOutlet weak var experienceDescriptionLbl: DynamicLabel!
    @IBOutlet weak var experienceContainerViewHieght: NSLayoutConstraint!
    
    
    @IBOutlet weak var qualificationsContainerView: UIView!
    @IBOutlet weak var qualificationsTitleLbl: UILabel!
    @IBOutlet weak var qualificationsDescriptionLbl: DynamicLabel!
    @IBOutlet weak var qualificationsContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ratesTitleLbl: UILabel!
    @IBOutlet weak var ratesDescriptionLbl: DynamicLabel!
    @IBOutlet weak var ratesContainerViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var ratesContainerView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var uploadDocumentsBtn: UIButton!
    
    // MARK:- Variables
    
    var imagePicker: ImagePicker?
    
    
    
    
    
    
        // MARK:- LifeCycle Methods
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aboutContainerViewHeight.constant = aboutTitleLbl.frame.size.height + aboutDescriptionLbl.frame.size.height + 30
        experienceContainerViewHieght.constant = experienceTitleLbl.frame.size.height + experienceDescriptionLbl.frame.size.height + 30
        qualificationsContainerViewHeight.constant = qualificationsTitleLbl.frame.size.height + qualificationsDescriptionLbl.frame.size.height + 30
        ratesContainerViewHeight.constant = ratesTitleLbl.frame.size.height + ratesDescriptionLbl.frame.size.height + 30
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        setLabels()
      
       
    }
    //MARK:- UI Methods
    
    private func setLabels() {
        registeredLbl.setIcon(text: "Registered", leftIcon: UIImage(named: "tick-icon"))
              specialExpLbl.setIcon(text: "Special Experience", leftIcon: UIImage(named: "tick-icon"))
              firstAidLbl.setIcon(text: "First Aid Training", leftIcon: UIImage(named: "tick-icon"))
              carehomeExpLbl.setIcon(text: "Care Home Experience", leftIcon: UIImage(named: "tick-icon"))
              dbsLbl.setIcon(text: "DBS Check", leftIcon: UIImage(named: "tick-icon"))
              careerQualificationLbl.setIcon(text: "Career Qualifications", leftIcon: UIImage(named: "tick-icon"))
        
        summaryTitleLbl.text = "My Summary"
         summaryTitleLbl.font = UIFont(name: Fonts.Book, size: 18)
         summaryTitleLbl.textColor = UIColor(rgb: 0x9A9AC6)
        summaryTitleLbl.changeFont(ofText: "Summary", with: UIFont(name: Fonts.Medium, size: 18)!)
         summaryTitleLbl.changeTextColor(ofText: "Summary", with: UIColor(rgb: 0x27418F))
        
        
        aboutTitleLbl.text = "About Me"
        aboutTitleLbl.font = UIFont(name: Fonts.Book, size: 18)
        aboutTitleLbl.textColor = UIColor(rgb: 0x9A9AC6)
        aboutTitleLbl.changeFont(ofText: "Me", with: UIFont(name: Fonts.Medium, size: 18)!)
        aboutTitleLbl.changeTextColor(ofText: "Me", with: UIColor(rgb: 0x27418F))
        
        experienceTitleLbl.text = "My Experience"
        experienceTitleLbl.font = UIFont(name: Fonts.Book, size: 18)
        experienceTitleLbl.textColor = UIColor(rgb: 0x9A9AC6)
        experienceTitleLbl.changeFont(ofText: "Experience", with: UIFont(name: Fonts.Medium, size: 18)!)
        experienceTitleLbl.changeTextColor(ofText: "Experience", with: UIColor(rgb: 0x27418F))
        
        qualificationsTitleLbl.text = "My Qualifications & Accreditation"
        qualificationsTitleLbl.font = UIFont(name: Fonts.Book, size: 18)
        qualificationsTitleLbl.textColor = UIColor(rgb: 0x9A9AC6)
        qualificationsTitleLbl.changeFont(ofText: "& Accreditation", with: UIFont(name: Fonts.Medium, size: 18)!)
        qualificationsTitleLbl.changeTextColor(ofText: "& Accreditation", with: UIColor(rgb: 0x27418F))
        
        ratesTitleLbl.text = "My Rates"
        ratesTitleLbl.font = UIFont(name: Fonts.Book, size: 18)
        ratesTitleLbl.textColor = UIColor(rgb: 0x9A9AC6)
        ratesTitleLbl.changeFont(ofText: "Rates", with: UIFont(name: Fonts.Medium, size: 18)!)
        ratesTitleLbl.changeTextColor(ofText: "Rates", with: UIColor(rgb: 0x27418F))
        
        
        
         
    }
  
    private func button(with title: String) -> UIButton {
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = title.size(withAttributes: attributes)

        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = size.height / 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height + 10.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        return button
    }

    
    
    
    // MARK:- IBAction Methods
    
    @IBAction func uploadDocuementsTapped(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
    
    // MARK:- Methods
   

}
extension ProfileView: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
       // self.imageView.image = image
        print("Image Selected")
    }
}
