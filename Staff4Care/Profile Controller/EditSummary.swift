//
//  EditSummary.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 02/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class EditSummary: UIViewController {

    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: EditProfileLabel!
    @IBOutlet weak var registeredTxtField: UITextField!
    @IBOutlet weak var specialExpTxtField: UITextField!
    @IBOutlet weak var firstAidTxtField: UITextField!
    @IBOutlet weak var carehomeExpTxtField: UITextField!
    @IBOutlet weak var dbsTxtField: UITextField!
    @IBOutlet weak var qualificationTextField: UITextField!
    @IBOutlet weak var extraSkillOne: UITextField!
    @IBOutlet weak var extraSkillTwo: UITextField!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var saveBtn: CustomButton!
    
    
    
    
    
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setTextFieldsPlaceHolder()
        mainViewHeight.constant = 680
    }
    
    
    // MARK: UI Methods
    private func setTitleLabel() {
        titleLabel.text = "My  Summary"
            titleLabel.font = UIFont(name: Fonts.Book, size: 18)
            titleLabel.textColor = UIColor(rgb: 0x9A9AC6)
        titleLabel.changeFont(ofText: "Summary", with: UIFont(name: Fonts.Demi, size: 18)!)
            titleLabel.changeTextColor(ofText: "Summary", with: UIColor(rgb: 0x27418F))
        
        registeredTxtField.layer.masksToBounds = true
        registeredTxtField.layer.cornerRadius = 12
        registeredTxtField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        registeredTxtField.layer.borderWidth = 2.0
        registeredTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        registeredTxtField.leftViewMode = .always
        
        specialExpTxtField.layer.masksToBounds = true
        specialExpTxtField.layer.cornerRadius = 12
        specialExpTxtField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        specialExpTxtField.layer.borderWidth = 2.0
        specialExpTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        specialExpTxtField.leftViewMode = .always
        
        firstAidTxtField.layer.masksToBounds = true
        firstAidTxtField.layer.cornerRadius = 12
        firstAidTxtField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        firstAidTxtField.layer.borderWidth = 2.0
        firstAidTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        firstAidTxtField.leftViewMode = .always
        
        
        carehomeExpTxtField.layer.masksToBounds = true
        carehomeExpTxtField.layer.cornerRadius = 12
        carehomeExpTxtField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        carehomeExpTxtField.layer.borderWidth = 2.0
        carehomeExpTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        carehomeExpTxtField.leftViewMode = .always
        
        dbsTxtField.layer.masksToBounds = true
        dbsTxtField.layer.cornerRadius = 12
        dbsTxtField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        dbsTxtField.layer.borderWidth = 2.0
        dbsTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        dbsTxtField.leftViewMode = .always
        
        qualificationTextField.layer.masksToBounds = true
        qualificationTextField.layer.cornerRadius = 12
        qualificationTextField.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        qualificationTextField.layer.borderWidth = 2.0
        qualificationTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        qualificationTextField.leftViewMode = .always
        
        extraSkillOne.layer.masksToBounds = true
        extraSkillOne.layer.cornerRadius = 12
        extraSkillOne.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        extraSkillOne.layer.borderWidth = 2.0
        extraSkillOne.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        extraSkillOne.leftViewMode = .always
        
        extraSkillTwo.layer.masksToBounds = true
        extraSkillTwo.layer.cornerRadius = 12
        extraSkillTwo.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
        extraSkillTwo.layer.borderWidth = 2.0
        extraSkillTwo.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: registeredTxtField.frame.height))
        extraSkillTwo.leftViewMode = .always
        
        saveBtn.setup(applyGradient: true,title: "Save",rgb1: (154,154,198),rgb2: (39,65,143))

        
        
    }
    private func setTextFieldsPlaceHolder() {
        
        registeredTxtField.attributedPlaceholder = NSAttributedString(string: "Registered", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
         specialExpTxtField.attributedPlaceholder = NSAttributedString(string: "Special Experience", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
         firstAidTxtField.attributedPlaceholder = NSAttributedString(string: "First Aid Training", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
         carehomeExpTxtField.attributedPlaceholder = NSAttributedString(string: "Care Home Experience", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
         dbsTxtField.attributedPlaceholder = NSAttributedString(string: "DBS Check", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
         qualificationTextField.attributedPlaceholder = NSAttributedString(string: "Career Qualifications", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
        
          extraSkillOne.attributedPlaceholder = NSAttributedString(string: "Add Text Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0xD1D1D1) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])
        
          extraSkillTwo.attributedPlaceholder = NSAttributedString(string: "Add Text Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0xD1D1D1) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 14)!])

    }
    
    // MARK:- IBAction Methods
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    

}
