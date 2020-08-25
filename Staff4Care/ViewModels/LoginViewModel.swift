//
//  LoginViewModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 18/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
protocol AuthenticationResponseDelegate: class{
    func userAuthenticationSuccess()
    func userAuthenticationFailure()
}

class LoginViewModel {
    
    var navigationController: UINavigationController?
    weak var authenticationDelegate: AuthenticationResponseDelegate?
    
    
    // MARK:- Network Methods
    func authenticateUser(userName: String , password:String) {
        let params = ["username": userName , "password": password,"device_id":Constants.UDID , "firebase_token":Constants.notification_token]
        let urlString = "https://api.bluenee.co.uk/cig/index.php/api/user/login"
        LoginServices.shared.loginUser(urlString: urlString, parameters: params) { result in
            switch result {
            case .success(let response):
                self.authenticationDelegate?.userAuthenticationSuccess()
                //self.responseDescription = response.message ?? "Unknown Error"
                if response.status! {
                    loggedUser = response
                    
                    
                    if let token = response.token {
                        userToken = token
                    }
                    
                    DispatchQueue.main.async {
                        if response.verifyAccount == "0"{
                            self.pushVerifyCodeVC(parentController: "L")
                            
                        }
                            
                        else{
                            
                            if response.profileComplete == "0" {
                                if response.role == "1" {
                                    self.pushRegistrationVC()
                                }
                                else if response.role == "2" {
                                    self.pushCareProviderRegistrationVC()
                                }
                                
                            }
                            else {
                                self.pushProfileVC()
                                
                            }
                        }
                        
                    }
                }
                else {
                    DispatchQueue.main.async {
                        // self.showPopUp(title: response.message!)
                    }
                    
                }
                
            case .failure(let reason):
                self.authenticationDelegate?.userAuthenticationFailure()
                print(reason)
            }
        }
    }
    
    func registerUser(userName: String,password: String,email: String,phone: String,selectedRole: String) {
        
        let params = ["username": userName , "password": password, "phone_number": phone , "email": email , "role": selectedRole,"device_id":Constants.UDID , "firebase_token":Constants.notification_token]
        let urlString = "https://api.bluenee.co.uk/cig/index.php/api/user/register"
        LoginServices.shared.signupUser(urlString: urlString, parameters: params) { (result) in
            switch result {
            case .success(let response):
                if response.message == "User is registered successfully!" {
                    signedupUser = response
                    if let token = response.token {
                        userToken = token
                    }
                    print("Successfully Registered!!")
                    DispatchQueue.main.async {
                        self.pushVerifyCodeVC(parentController: "S")
                    }
                }
            case .failure(let reason):
                print("Failure Reason :: " , reason)
            }
        }
        
    }
    
}
// MARK:- Navigation Methods
extension LoginViewModel {
    
    func pushProfileVC() {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(identifier: "UserProfile") as? UserProfile else {
            print("ViewController not found")
            return
        }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    func pushRegistrationVC() {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        guard let registrationVC = storyboard.instantiateViewController(identifier: "Registration") as? Registration else {
            print("ViewController not found")
            return
        }
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    func pushVerifyCodeVC(parentController: String) {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        guard let verifyCode = storyboard.instantiateViewController(identifier: "VerifyCode") as? VerifyCode else {
            
            print("ViewController not found")
            return
        }
        verifyCode.verificationCode = loggedUser?.verificationCode
        verifyCode.parentController = parentController
        self.navigationController?.pushViewController(verifyCode, animated: true)
    }
    func pushPaymentVC() {
        let storyboard = UIStoryboard(name: "Payments", bundle: nil)
        guard let verifyCode = storyboard.instantiateViewController(identifier: "Payments") as? Payments else {
            
            print("ViewController not found")
            return
        }
        
        self.navigationController?.pushViewController(verifyCode, animated: true)
    }
    func pushCareProviderRegistrationVC() {
        let storyboard = UIStoryboard(name: "HospitalRegistration", bundle: nil)
        guard let registrationVC = storyboard.instantiateViewController(identifier: "HospitalRegistration") as? HospitalRegistration else {
            
            print("ViewController not found")
            return
        }
        
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
}
