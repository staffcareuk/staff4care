//
//  Registration.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 25/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import CoreLocation

class Registration: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var usernameField: CustomTextField!
    @IBOutlet weak var phoneField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var designationField: CustomTextField!
    @IBOutlet weak var postcodeField: CustomTextField!
    @IBOutlet weak var experienceField: CustomTextField!
    @IBOutlet weak var registrationField: CustomTextField!
    @IBOutlet weak var ethnicBGField: CustomTextField!
    @IBOutlet weak var habitField: CustomTextField!
    @IBOutlet weak var addressField: CustomTextField!
    @IBOutlet weak var dayField: CustomTextField!
    @IBOutlet weak var monthField: CustomTextField!
    @IBOutlet weak var yearField: CustomTextField!
    @IBOutlet weak var bankField: CustomTextField!
    
    @IBOutlet weak var accountField: CustomTextField!
    @IBOutlet weak var verifyBtn: CustomButton!
    @IBOutlet weak var verifyLabel: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var bankDetailLbl: UILabel!
    @IBOutlet weak var sortCodeLbl: UILabel!
    @IBOutlet weak var sortCodeFieldsStack: UIStackView!
    @IBOutlet weak var staffRegisterationLbl: UILabel!
    @IBOutlet weak var topTitleLbl: UILabel!
    
    // MARK:- Variables
    var dayPicker  = UIPickerView()
    var monthPicker = UIPickerView()
    var yearPicker = UIPickerView()
    var days = [String]()
    var month = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var year = [String]()
    var DOB: String = ""
    
    // Locator
    var locationManager = CLLocationManager()
    var latitude   = ""
    var longitude  = ""
    
    
    // MARK:- LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFields()
        setLabels()
        for i in 1...30 {
            days.append(String(i))
        }
       
        for i in 1899...2019 {
            year.append(String(i))
        }
        
        // Get Location
        setLocationProperties()
       

    
      
        
    }
    // MARK:- Methods
    private func setLocationProperties() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    private func prepareTextFields(){
        usernameField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Username")
        phoneField.addAttributedPlaceholder        (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Phone Number")
        emailField.addAttributedPlaceholder        (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Email")
        designationField.addAttributedPlaceholder  (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Designation")
        postcodeField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Postcode")
        experienceField.addAttributedPlaceholder   (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Experience")
        registrationField.addAttributedPlaceholder (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Registration Number")
        ethnicBGField.addAttributedPlaceholder     (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Ethnic Background")
        habitField.addAttributedPlaceholder        (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Habit")
        addressField.addAttributedPlaceholder      (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Address")
        dayField.addAttributedPlaceholder          (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Day")
        monthField.addAttributedPlaceholder        (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Month")
        yearField.addAttributedPlaceholder         (font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Year")
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
    private func setLabels() {
        
        topTitleLbl.text = "Staff4Care"
        topTitleLbl.font = UIFont(name: Fonts.Medium, size: 16)
        topTitleLbl.textColor = UIColor(rgb: 0x27418F)
       // topTitleLbl.changeFont(ofText: "Care", with: UIFont(name: Fonts.Medium, size: 14)!)
        topTitleLbl.changeTextColor(ofText: "Care", with: UIColor(rgb: 0xAEC837))
        
        staffRegisterationLbl.text = "Staff Registration"
        staffRegisterationLbl.font = UIFont(name: Fonts.Book, size: 16)
        staffRegisterationLbl.textColor = UIColor(rgb: 0x9A9AC6)
         staffRegisterationLbl.changeFont(ofText: "Registration", with: UIFont(name: Fonts.Demi, size: 16)!)
        staffRegisterationLbl.changeTextColor(ofText: "Registration", with: UIColor(rgb: 0x27418F))
        
        bankDetailLbl.text = "Bank Detail"
        bankDetailLbl.font = UIFont(name: Fonts.Book, size: 16)
        bankDetailLbl.textColor = UIColor(rgb: 0x9A9AC6)
        bankDetailLbl.changeFont(ofText: "Detail", with: UIFont(name: Fonts.Demi, size: 16)!)
        bankDetailLbl.changeTextColor(ofText: "Detail", with: UIColor(rgb: 0x27418F))
        
        verifyBtn.setup(applyGradient: true,title: "Getting Started",rgb1: (154,154,198),rgb2: (39,65,143))
        
    }
    
    
    // MARK:- IBAction Methods
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        registerUser()
    }
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func termsButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    // MARK:- Network Methods
    func registerUser() {
        guard let userName = self.usernameField.text, !userName.isEmpty else {
            return
        }
        guard let designation = self.designationField.text, !designation.isEmpty else {
            return
        }
        guard let postCode = self.postcodeField.text, !postCode.isEmpty else {
            return
        }
        guard let experience = self.experienceField.text, !experience.isEmpty else {
            return
        }
        guard let regNo = self.registrationField.text, !regNo.isEmpty else {
            return
        }
        guard let ethnicBG = self.ethnicBGField.text, !ethnicBG.isEmpty else {
            return
        }
        guard let habit = self.habitField.text, !habit.isEmpty else {
            return
        }
        guard let address = self.addressField.text, !address.isEmpty else {
                   return
               }
        guard let sortCode1 = (self.sortCodeFieldsStack.subviews[0] as? UITextField)!.text, !sortCode1.isEmpty else {
                   return
               }
        guard let sortCode2 = (self.sortCodeFieldsStack.subviews[1] as? UITextField)!.text, !sortCode2.isEmpty else {
                          return
                      }
        guard let sortCode3 = (self.sortCodeFieldsStack.subviews[2] as? UITextField)!.text, !sortCode3.isEmpty else {
                          return
                      }
        guard let accountNo = self.accountField.text, !accountNo.isEmpty else {
                          return
                      }
        
        guard let bankName = self.bankField.text, !bankName.isEmpty else {
                          return
                      }
        guard let day = self.dayField.text, !day.isEmpty else {
                                 return
                             }
        guard let month = self.monthField.text, !month.isEmpty else {
                                 return
                             }
        guard let year = self.yearField.text, !year.isEmpty else {
                                 return
                             }
        DOB = dayField.text! + "-" + monthField.text!
        DOB += "-" + yearField.text!
        
        let params = ["name": userName , "designation": designation , "date_of_birth": DOB,
                      "postcode": postCode , "experience": experience , "registration_no": regNo,
                      "ethnic_background": ethnicBG , "habit": habit , "address": address, "sort_code_1":sortCode1,"sort_code_2":sortCode2,"sort_code_3":sortCode3,"account_no":accountNo,"bank_name":bankName,"gendar": "Male","longitude":self.latitude,"latitude":self.longitude] as [String : Any]
        let urlString = "https://api.bluenee.co.uk/cig/index.php/api/staff/register/"+(loggedUser?.userID)!
        LoginServices.shared.registerUser(urlString: urlString, parameters: params) { (result) in
            switch result{
            case .success(let response):
                if response.responseCode == 200 {
                    DispatchQueue.main.async {
                        self.pushProfileVC()
                        
                    }
                }
            case .failure(let reason):
                print(reason)
            }
        }
        
        
        print("All Success")
        
        
        
    }
    
    
    func pushProfileVC() {
            let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                          guard let loginVC = storyboard.instantiateViewController(identifier: "UserProfile") as? UserProfile else {
                                 print("ViewController not found")
                                 return
                             }
         self.navigationController?.pushViewController(loginVC, animated: true)
        }
    
    
}

// MARK:- TextField Delegate
extension Registration: UITextFieldDelegate {
    
}

extension Registration: UIPickerViewDelegate , UIPickerViewDataSource{
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
extension Registration: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        if let lat = location?.coordinate.latitude , let lang = location?.coordinate.longitude {
             self.latitude  = String(lat)
             self.longitude = String(lang)
        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
}
