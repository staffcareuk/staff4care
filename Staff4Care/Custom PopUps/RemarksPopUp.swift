//
//  RemarksPopUp.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 22/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class RemarksPopUp: UIViewController , UIGestureRecognizerDelegate{

    // MARK:- IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remarksTextField: UITextField!
    @IBOutlet weak var applyJobBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
   
    // MARK:- Variables
    
    var remarksCallBack : ((String) -> () )?
    
    
    
    // MARK:- LifeCycle Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.backgroundColor = .secondarySystemBackground
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
         showAnimate()
         addPropertiesAndStyling()

        // Do any additional setup after loading the view.
    }
    // MARK:- Animation Methods
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
       // MARK:- Methods
    private func addPropertiesAndStyling(){
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
                  view.addGestureRecognizer(tapGesture)
                  tapGesture.delegate = self
                  
           let string2 = NSAttributedString(string: "Apply Job", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 18)!])
                            applyJobBtn.setAttributedTitle(NSAttributedString(attributedString: string2), for: .normal)
                            applyJobBtn.setGradientBackgroundColor(colors: [ UIColor(red: 154/255.0, green: 154/255.0, blue: 198/255.0, alpha: 1.0), UIColor(red: 39/255.0, green: 65/255.0, blue: 143/255.0, alpha: 1.0)], axis: .vertical, cornerRadius: 25) { view in
                               guard let btn = view as? UIButton, let imageView = btn.imageView else { return }
                               btn.bringSubviewToFront(imageView) // To display imageview of button
                           }
        cancelBtn.layer.borderWidth = 2.0
        cancelBtn.layer.borderColor = UIColor(rgb: 0x27418F).cgColor
        cancelBtn.layer.masksToBounds = true
        cancelBtn.layer.cornerRadius = 25.0
         let string = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 18)!])
        cancelBtn.setAttributedTitle(string, for: .normal)
        
        let titleString = NSAttributedString(string: "Enter your Remarks", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 18)!])
        titleLabel.attributedText = titleString
                  
        cancelBtn.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        applyJobBtn.addTarget(self, action: #selector(remarksEntered), for: .touchUpInside)
           
       }
    @objc func remarksEntered() {
        if let remarks = remarksTextField.text {
            remarksCallBack?(remarks)
            removeAnimate()

        }
    }
    @objc func dismissPopUp() {
        remarksCallBack?("")
        removeAnimate()
    }
    
    @objc func dismissVC(){
        removeAnimate()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let p = touch.location(in: self.view)
        if self.containerView.frame.contains(p) {
          return false
        }
        return true
    }
}
