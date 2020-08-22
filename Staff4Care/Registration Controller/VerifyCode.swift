//
//  VerifyCode.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 26/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import PinCodeTextField
class VerifyCode: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var joinBtn: CustomButton!
    @IBOutlet weak var pincodeTextField: PinCodeTextField!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    

    // MARK:- Variables
    var verificationCode: String?
    var parentController: String?
    var userID: String = ""
    
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        print("Code :: " , verificationCode)
        super.viewDidLoad()
        
    joinBtn.setup(applyGradient: true,title: "Join Now",rgb1: (154,154,198),rgb2: (39,65,143))
        phoneLbl.text = loggedUser?.phoneNumber
        phoneLbl.text?.insert("-", at: (phoneLbl.text?.index(phoneLbl.text!.startIndex, offsetBy: 4))!)
        
        
    }
    
    
    @IBAction func joinNowTapped(_ sender: UIButton) {
        let code = pincodeTextField.text
        let params = ["verification_code": code]
        if parentController == "L" {
            if let Id = loggedUser?.userID {
                self.userID = Id
            }
            
        } else {
            if let Id = signedupUser?.userID {
                self.userID = String(Id)
            }
            
        }
        let urlString = "https://api.bluenee.co.uk/cig/index.php/api/user/verificationcode/"+userID
        LoginServices.shared.verifyCode(urlString: urlString, parameters: params as [String : Any]) { (result) in
            switch result {
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


