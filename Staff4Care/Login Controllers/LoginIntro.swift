//
//  LoginIntro.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 16/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class LoginIntro: UIViewController {

    @IBOutlet weak var getStartedButton: CustomButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStartedButton.setup(applyGradient: true,title: "Getting Started",rgb1: (154,154,198),rgb2: (39,65,143))
    }
    // UI Methods
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        getStartedButton.addTarget(self, action: #selector(pushLoginVC), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    @objc func pushLoginVC() {
        let storyboard = UIStoryboard(name: "LoginScreens", bundle: nil)
               guard let loginVC = storyboard.instantiateViewController(identifier: "Login") as? Login else {
                      print("ViewController not found")
                      return
                  }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    


}
