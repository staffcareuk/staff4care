//
//  PopUpView.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 08/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class PopUpView: UIViewController {
   
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    
    
    
    var yesCallBack = {}
    var noCallBack = {}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissVC)))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.8)

        showAnimate()
        yesBtn.setup(applyGradient: true,title: "Yes",rgb1: (154,154,198),rgb2: (39,65,143))
        noBtn.setup(applyGradient: true,title: "No",rgb1: (192,221,184),rgb2: (174,200,55))
    }
    @objc func dismissVC() {
        print("Tapped")
        self.removeAnimate()
    }
   
    func updateHeight(height: CGFloat) {
        self.containerViewHeight.constant = height
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
    // MARK:- IBAction Methods
    @IBAction func yesButtonTapped(_ sender: Any) {
        removeAnimate()
       // dismiss(animated: true, completion: nil)
        yesCallBack()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        removeAnimate()
      //  dismiss(animated: true, completion: nil)
        noCallBack()
    }
    
}
