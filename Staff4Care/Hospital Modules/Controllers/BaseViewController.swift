//
//  BaseViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 23/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var leftNavigationButton  = UIButton()
    var navigationBar         = UIView()
    var navigationBarTitle    = UILabel()
    var bottomLayer           = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        addTitleLabel()
        addNavigationButton()
    }
    
    // MARK:- Methods
    func addNavigationBar() {
        
        self.view.addSubview(navigationBar)
        navigationBar.backgroundColor = .tertiarySystemBackground
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
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
