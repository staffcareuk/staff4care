//
//  Login.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 17/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
class Login: UIViewController  {

    // MARK: IBOutlets
    @IBOutlet weak var loginCardViewHeight: NSLayoutConstraint!
    @IBOutlet weak var loginCardViewWidth: NSLayoutConstraint!
    @IBOutlet weak var loginCardViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var loginCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titlesStackView: UIStackView!
    @IBOutlet weak var nextButton: CustomButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var bottomLayerView: UIView!
    @IBOutlet weak var bottomLayerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var expandedView: UIView!
    @IBOutlet weak var careProviderLabel: ClickableLabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var staffLabel: ClickableLabel!
    @IBOutlet weak var expandedViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedRoleLabel: UILabel!
    @IBOutlet weak var textFieldsStack: UIStackView!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var usernameField: CustomTextField!
    @IBOutlet weak var phoneNoField: CustomTextField!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var rememberMeBtn: UIButton!
  
    @IBOutlet weak var forgotPwdLabel: UILabel!
    
    @IBOutlet weak var increaseHeight: NSLayoutConstraint!
    @IBOutlet weak var genderStackView: UIStackView!
    @IBOutlet weak var linkLabel: UILabel!
    
    // MARK: Variables
    var previousFrameToReset = CGRect()
    var previousFrameToConstant = CGRect()
    var showFilterMenu = false
    var heightIncreased = false
    var heightReduced = false
    var responseDescription = ""
    var selectedRole = ""
    var selectedTab = "L"
    // View Model Object
    var loginVM = LoginViewModel()
   
   
    
    
    
    
    // MARK: LifeCycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginCardView.clipsToBounds = true
        loginCardView.layer.cornerRadius = 12.0
        loginCardView.addShadow(offset: CGSize.init(width: 0, height: 5), color: UIColor.black, radius: 4.0, opacity: 0.5)
        expandedView.clipsToBounds = true
        expandedView.layer.cornerRadius = 12.0
        expandedView.addShadow(offset: CGSize.init(width: 0, height: 5), color: UIColor.black, radius: 4.0, opacity: 0.5)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  loginCardView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)
        nextButton.addRoundedBorder(shadowColor: 0x707070)
      

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraintsAndProperties()
        setupTitle()
        loginVM.navigationController = self.navigationController
    
        // UILabel Click CallBacks
        self.staffLabel.onClick = {
            self.selectedRoleLabel.text = self.staffLabel.text
            self.showFilterMenu = true
            self.fadeAnimateView()
            self.selectedRole = "1"
        }
        self.careProviderLabel.onClick = {
            self.selectedRoleLabel.text = self.careProviderLabel.text
            self.showFilterMenu = true
            self.fadeAnimateView()
            self.selectedRole = "2"
        }
        
      
        
    }
    
    
    // MARK: UI Methods
    private func showPopUp(title: String) {
        if let popvc = UIStoryboard(name: "PopUpView", bundle: nil).instantiateViewController(withIdentifier: "PopUpView") as? PopUpView
        {
            
            self.addChild(popvc)
            
            popvc.view.frame = self.view.frame
            
            self.view.addSubview(popvc.view)
            popvc.titleLabel.text = title
            popvc.buttonStackView.isHidden = true
             popvc.updateHeight(height: popvc.titleLabel.intrinsicContentSize.height + 170)
            popvc.containerView.backgroundColor = .black
            popvc.didMove(toParent: self)
//            popvc.yesCallBack = { [unowned self] in
//                                   print("Yes")
//                               }
//                               popvc.noCallBack = { [unowned self] in
//                                   print("No")
//                               }

        
        }
          
    }
    private func showPopUpInPresentationStyle() {
        if let popvc = UIStoryboard(name: "PopUpView", bundle: nil).instantiateViewController(withIdentifier: "PopUpView") as? PopUpView
        {
            popvc.modalPresentationStyle = .overCurrentContext
            popvc.modalTransitionStyle = .coverVertical
            self.present(popvc, animated: true, completion: nil)
            popvc.updateHeight(height: 160)
//            popvc.yesCallBack = { [unowned self] in
//                        print("Yes")
//                    }
//                    popvc.noCallBack = { [unowned self] in
//                        print("No")
//                    }

        }
        
        
    }
    private func setupConstraintsAndProperties() {
        loginCardViewHeight.constant  =   UIScreen.main.bounds.size.height * 0.45
        loginCardViewWidth.constant   =   UIScreen.main.bounds.size.width * 0.85
        loginCardViewCenterY.constant =   UIScreen.main.bounds.size.height * 0.02
        bottomLayerViewWidth.constant =   (loginCardViewWidth.constant / 2) - 30
        
        previousFrameToConstant = bottomLayerView.frame
        self.expandedView.isHidden = true
        self.staffLabel.isUserInteractionEnabled = true
        self.careProviderLabel.isUserInteractionEnabled = true
        
        usernameField.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Enter Username")
        
        emailField.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Enter Email")
        passwordField.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Enter Password")
        phoneNoField.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: "Enter Phone Number")
        
        passwordField.isSecureTextEntry = true
        emailField.tag = 1
        passwordField.tag = 3
       

    }
   
    private func setupTitle() {
        titleLabel.text = "Welcome to Staff4Care"
        titleLabel.font = UIFont(name: Fonts.Book, size: 24)
        titleLabel.textColor = .white
        titleLabel.changeFont(ofText: "Staff4Care", with: UIFont(name: Fonts.Demi, size: 24)!)
        
        linkLabel.text = "By pressing 'Submit' you agree to our Terms & Conditions"
        linkLabel.font = UIFont(name: Fonts.Book, size: 14)
        linkLabel.textColor = UIColor(rgb: 0x707070)
        linkLabel.changeFont(ofText: "Terms & Conditions", with: UIFont(name: Fonts.Medium, size: 14)!)
        linkLabel.changeTextColor(ofText: "Terms & Conditions", with: UIColor(rgb: 0xC0DDB8))
        
        
        
    }
    private func changeAppearance(button: UIButton) {
        if button == loginButton {
            button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
            signUpButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
        }
        else if button == signUpButton{
            button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
            loginButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
        }
        
    }
   
    // MARK: IBAction Methods
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if selectedTab == "L" {
            loginVM.authenticateUser(userName: usernameField.text!, password: passwordField.text!)
        } else if selectedTab == "S" {
            loginVM.registerUser(userName: usernameField.text!, password: passwordField.text!, email: emailField.text!, phone: phoneNoField.text!, selectedRole: self.selectedRole)
        }
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
     
        selectedTab = "L"

        increaseHeight.isActive = false
        loginCardViewHeight.isActive = true
      
        genderStackView.isHidden = true
        emailField.isHidden = true
        phoneNoField.isHidden = true
               bottomView.isHidden = false
               bottomView.alpha = 0.0
        linkLabel.isHidden = true
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomView.alpha = 1.0
               self.view.layoutIfNeeded()
           // self.loginCardView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)

               }, completion: { _ in
                self.animateBottomLayerBackward()
                     self.changeAppearance(button: sender)
               })
               
         heightIncreased = false
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        selectedTab = "S"
      
        loginCardViewHeight.isActive = false
               increaseHeight.isActive = true
      
//        self.usernameField.isHidden = false
//        self.usernameField.alpha = 0.0
        self.emailField.isHidden = false
        self.emailField.alpha = 0.0
        self.phoneNoField.isHidden = false
        self.phoneNoField.alpha = 0.0
        
        
        genderStackView.isHidden = false
        bottomView.isHidden = true
        genderStackView.alpha = 0.0
        linkLabel.isHidden = false
        linkLabel.alpha = 0.0

       UIView.animate(withDuration: 0.4, animations: {
       
        //self.usernameField.alpha = 1.0
        self.genderStackView.alpha = 1.0
        self.emailField.alpha = 1.0
        self.phoneNoField.alpha = 1.0
        self.linkLabel.alpha = 1.0
        

        self.view.layoutIfNeeded()
       
       

        }, completion: { _ in
          
           
            self.changeAppearance(button: sender)
                      
                      self.animateBottomLayerForward()
            
//            UIView.animate(withDuration: 0.2) {
//                 self.loginCardView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)
//                                          self.loginCardView.layer.setNeedsDisplay()
//                                          self.loginCardView.layer.displayIfNeeded()
//            }
        })
        
         heightReduced = false

    }
    @IBAction func rememberMeBtnTapped(_ sender: Any) {
    }
    @IBAction func dropDownButtonPressed(_ sender: Any) {
       fadeAnimateView()
    }
   
    // MARK: Animation Methods
    
    private func animateBottomLayerForward() {
        previousFrameToReset = bottomLayerView.frame
        
        UIView.animate(withDuration: 0.3) {
            self.bottomLayerView.frame = CGRect(x: self.loginCardView.frame.width / 2 + 15, y: self.previousFrameToReset.origin.y, width: self.previousFrameToReset.width, height: self.previousFrameToReset.height)
        }
    }
    private func animateBottomLayerBackward() {
        
        UIView.animate(withDuration: 0.3) {
            self.bottomLayerView.frame = CGRect(x: self.previousFrameToConstant.origin.x, y: self.previousFrameToConstant.origin.y, width: self.previousFrameToConstant.width, height: self.previousFrameToConstant.height)
        }
    }
   
    private func fadeAnimateView() {

        if showFilterMenu == false {
            self.expandedView.alpha = 0.0
            self.expandedView.isHidden = false
            self.showFilterMenu = true

            UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
                            self?.expandedView.alpha = 1.0
                            self?.textFieldsStack.frame.origin.y += (self?.expandedViewHeight.constant) ?? 100
                            self?.bottomView.frame.origin.y += (self?.expandedViewHeight.constant) ?? 100
                             self?.nextButton.frame.origin.y += (self?.expandedViewHeight.constant) ?? 100
                           
            })
        } else {
            UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
                            self?.expandedView.alpha = 0.0
                            self?.textFieldsStack.frame.origin.y -= (self?.expandedViewHeight.constant) ?? 100
                             self?.bottomView.frame.origin.y -= (self?.expandedViewHeight.constant) ?? 100
                             self?.nextButton.frame.origin.y -= (self?.expandedViewHeight.constant) ?? 100
                          
            }) { [weak self] _ in
                self?.expandedView.isHidden = true
                self?.showFilterMenu = false
            }
        }
    }
    
 

}

