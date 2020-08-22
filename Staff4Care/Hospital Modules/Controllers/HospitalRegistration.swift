//
//  HospitalRegistration.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 23/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class HospitalRegistration: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var hospitalName: CustomTextField!
    @IBOutlet weak var phone1: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var postcodeField: CustomTextField!
    @IBOutlet weak var addressField: CustomTextField!
    @IBOutlet weak var userName: CustomTextField!
    @IBOutlet weak var userPhone: CustomTextField!
    @IBOutlet weak var userEmail: CustomTextField!
    @IBOutlet weak var designationField: CustomTextField!
    @IBOutlet weak var dayField: CustomTextField!
    @IBOutlet weak var monthField: CustomTextField!
    @IBOutlet weak var yearField: CustomTextField!
    @IBOutlet weak var registrationNumber: CustomTextField!
    @IBOutlet weak var kinInformation: CustomTextField!
    @IBOutlet weak var cardFullName: CustomTextField!
    @IBOutlet weak var cardNo: CustomTextField!
    @IBOutlet weak var expiryDate: CustomTextField!
    @IBOutlet weak var CVCField: CustomTextField!
    @IBOutlet weak var verifyBtn: CustomButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var TermsBtn: UIButton!
    
    
    
    
    
    
    
    
    
    
    
    // MARK:- Variables
    var dayPicker  = UIPickerView()
    var monthPicker = UIPickerView()
    var yearPicker = UIPickerView()
    var days = [String]()
    var month = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var year = [String]()
    
    
    
    
    // MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        prepareTextFields()
        for i in 1...30 {
             days.append(String(i))
         }
        
         for i in 1899...2019 {
             year.append(String(i))
         }

    }
    
    // MARK:- IBActions
    @IBAction func emailSubscribeButtonTapped(_ sender: Any) {
    }
    @IBAction func termsAndConditionsTapped(_ sender: Any) {
    }
    @IBAction func verifyNowTapped(_ sender: Any) {
        guard let hospitalName = self.hospitalName.text else {
                   return
               }
        guard let userName = self.userName.text else {
                          return
                      }
        guard let designation = self.designationField.text else {
                          return
                      }
        guard let email = self.userEmail.text else {
                          return
                      }
        guard let phone = self.userPhone.text else {
                          return
                      }
        guard let day = self.dayField.text else {
                          return
                      }
        guard let month = self.monthField.text else {
                          return
                      }
        guard let year = self.yearField.text else {
                          return
                      }
        var DOB = day + "-" + month
        DOB = DOB + "-" + year
        
        guard let postcode = self.postcodeField.text else {
                          return
                      }
        guard let address = self.addressField.text else {
                          return
                      }
        guard let regNo = self.registrationNumber.text else {
                          return
                      }
        guard let kin = self.kinInformation.text else {
                          return
                      }
        guard let cardName = self.cardFullName.text else {
                          return
                      }
        guard let expDate = self.expiryDate.text else {
                          return
                      }
        guard let cvc = self.CVCField.text else {
                          return
                      }
        let gender = "Male"
        
        let params = ["hospital_name": hospitalName , "contact_name": userName , "contact_designation": designation , "contact_email": email , "contact_phone": phone , "date_of_birth": DOB , "postcode": postcode , "address": address , "registration_no": regNo , "next_of_kin": kin , "card_full_name": cardName , "expiry_date": expDate , "cvc": cvc , "gendar": gender] as [String:Any]
              let urlString = "https://api.bluenee.co.uk/cig/index.php/api/care/register/"+(loggedUser?.userID)!
        LoginServices.shared.registerCareProvider(urlString: urlString, parameters: params) { (result) in
            switch result {
            case .success(let resposne):
                if resposne.responseCode == 200 {
                    DispatchQueue.main.async {
                        self.pushProfileVC()
                    }
                }
            case .failure(let reason):
                print("Reason :: " , reason)
            }
        }
    }
    // MARK:- Methods
    private func prepareTextFields(){
          hospitalName.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Hospital Name")
         phone1.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Phone Number")
         email.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Email")
         postcodeField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Postcode")
          addressField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Address")
          userName.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "User Name")
         userPhone.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Phone Number")
         userEmail.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Email")
         designationField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Designation")
         dayField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Day")
         monthField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Month")
         yearField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Year")
         registrationNumber.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Registration Number")
         kinInformation.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Next of Kin Information")
         cardFullName.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Full Name")
         cardNo.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Card Number")
         expiryDate.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "DD-MM-YYYY")
         CVCField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "CVC")
        verifyBtn.setup(applyGradient: true,title: "Verify Now",rgb1: (192,221,184),rgb2: (174,200,55))
        dayField.delegate = self
        monthField.delegate = self
        yearField.delegate = self
        dayPicker.delegate = self
        dayPicker.dataSource = self
        
        monthPicker.delegate = self
        monthPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        dayField.inputView = dayPicker
        monthField.inputView = monthPicker
        yearField.inputView = yearPicker
        
    }
}
// MARK:- TextField Delegate
extension HospitalRegistration: UITextFieldDelegate {
    
}

extension HospitalRegistration: UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
   

       // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == dayPicker {
            return days.count
        }
        else if pickerView == monthPicker {
            return month.count
        }
        else {
            return year.count
        }
       }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          if pickerView == dayPicker {
               return days[row]
           }
           else if pickerView == monthPicker {
               return month[row]
           }
           else {
               return year[row]
           }
       }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
        if pickerView == dayPicker {
            dayField.text = days[row]
        }
        else if pickerView == monthPicker {
            monthField.text = month[row]
        }
        else {
            yearField.text = year[row]
        }
       }

    
    
}
extension HospitalRegistration {
    func pushProfileVC() {
            let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                          guard let loginVC = storyboard.instantiateViewController(identifier: "UserProfile") as? UserProfile else {
                                 print("ViewController not found")
                                 return
                             }
         self.navigationController?.pushViewController(loginVC, animated: true)
        }
    

}
