//
//  SignUpViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 23/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class SignUp: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var loginCardView: UIView!
    @IBOutlet weak var bottomLayerView: UIView!
    @IBOutlet weak var selectedRoleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginCardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var loginCardViewWidth: NSLayoutConstraint!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var expandedView: UIView!
    @IBOutlet weak var careProviderLabel: ClickableLabel!
    @IBOutlet weak var staffLabel: ClickableLabel!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var rememberMeBtn: UIButton!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var forgotPwdLabel: UILabel!
    
    
    
    
    
    
    // MARK:- Variables
    
    
    
    
    
    // MARK:- LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- IBAction Methods
    @IBAction func dropDownButtonPressed(_ sender: Any) {
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    @IBAction func signupButtonTapped(_ sender: Any) {
    }
    @IBAction func rememberMeBtnTapped(_ sender: Any) {
    }
    
  
}
