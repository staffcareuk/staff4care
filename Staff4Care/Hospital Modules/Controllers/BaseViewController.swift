//
//  BaseViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 23/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class BaseViewController: UIViewController {

    var leftNavigationButton  = UIButton()
    var navigationBar         = UIView()
    var navigationBarTitle    = UILabel()
    var bottomLayer           = UIView()
    
    var hasNotch              = false
    
    // Activity Indicator
    var spinner = NVActivityIndicatorView(frame: .zero, type: .ballDoubleBounce, color:  UIColor(rgb: 0x27418F), padding: 10)
    // Blur View
    let blurEffectBackground = UIBlurEffect(style: UIBlurEffect.Style.light)
    lazy var blurEffectViewBackground = UIVisualEffectView(effect: blurEffectBackground)
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        addTitleLabel()
        addNavigationButton()
        
        
    }
    
    // MARK:- Methods
    func buttonCallBack() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: UserProfile.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
   
    func showPopUp(title: String,success: Bool,showFilledBtn: Bool) {
           if let popvc = UIStoryboard(name: "PopUpView", bundle: nil).instantiateViewController(withIdentifier: "GenericPopUp") as? GenericPopUp
           {
               self.addChild(popvc)
              
               popvc.view.frame = self.view.frame
               self.view.addSubview(popvc.view)
               popvc.titleLbl.text = title
               popvc.containerView.backgroundColor = .tertiarySystemBackground
            if success {
                popvc.icon.image = UIImage(named: "ic_tick")
            } else {
                popvc.icon.image = UIImage(named: "ic_cross")
            }
            if showFilledBtn {
                popvc.filledBtn.isHidden = false
                popvc.subtitleLbl.isHidden = true
            } else {
                popvc.removeElements()
            }
               popvc.didMove(toParent: self)
            
               // Call Back
            popvc.callBack = { [weak self] in
                self?.buttonCallBack()
            }
           }
        
             
       }
    
     func startIndicator() {
          
          addBlurViewforActivity()
          view.addSubview(spinner)
          spinner.translatesAutoresizingMaskIntoConstraints = false
          spinner.heightAnchor.constraint(equalToConstant: 70).isActive = true
          spinner.widthAnchor.constraint(equalToConstant: 70).isActive = true
          spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
          
      }
    func stopIndicator() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        removeBlurViewforActivity()
    }
    
    func addBlurViewforActivity() {
        blurEffectViewBackground.frame = view.bounds
        blurEffectViewBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectViewBackground)
        blurEffectViewBackground.alpha = 0
        blurEffectViewBackground.isHidden = true
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.blurEffectViewBackground.isHidden = false
            self?.blurEffectViewBackground.alpha = 0.6
            
        }) { (finished) in
            if finished {
                self.spinner.startAnimating()
            }
        }
        
    }
    func removeBlurViewforActivity() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.blurEffectViewBackground.alpha = 0
            self?.blurEffectViewBackground.isHidden = true
            
        }) { (finished) in
            if finished {
                self.blurEffectViewBackground.removeFromSuperview()
            }
        }
    }
    func addNavigationBar() {
        
        self.view.addSubview(navigationBar)
        navigationBar.backgroundColor = .tertiarySystemBackground
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.hasNotch {
            navigationBar.heightAnchor.constraint(equalToConstant: 84).isActive = true
            hasNotch = true

        } else {
            navigationBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
            hasNotch = false

        }
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        self.view.addSubview(bottomLayer)
        
        bottomLayer.backgroundColor = .red
        bottomLayer.translatesAutoresizingMaskIntoConstraints = false
        bottomLayer.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLayer.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0).isActive = true
        bottomLayer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bottomLayer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
    }
    func addNavigationButton(){
        navigationBar.addSubview(leftNavigationButton)
        leftNavigationButton.setImage(UIImage(named: "arrow-back"), for: .normal)
        leftNavigationButton.translatesAutoresizingMaskIntoConstraints = false
        leftNavigationButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor, constant: 15).isActive = true
        leftNavigationButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        leftNavigationButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        leftNavigationButton.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 0).isActive = true
        
        leftNavigationButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        leftNavigationButton.tintColor = .black
    }
    func addTitleLabel() {
        navigationBar.addSubview(navigationBarTitle)
        navigationBarTitle.translatesAutoresizingMaskIntoConstraints = false
        navigationBarTitle.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        navigationBarTitle.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 45).isActive = true

        navigationBarTitle.text = "Staff4Care"
        navigationBarTitle.font = UIFont(name: Fonts.Medium, size: 16)
        navigationBarTitle.textColor = UIColor(rgb: 0x27418F)
        navigationBarTitle.changeTextColor(ofText: "Care", with: UIColor(rgb: 0xAEC837))
    }
    func hideNavigationBar() {
        navigationBar.isHidden = true
        bottomLayer.isHidden = true
    }
    
    // MARK:- Action Methods
    @objc func backButtonTapped() {
        print("Super Back")
    }
}
