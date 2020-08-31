//
//  GenericPopUp.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 26/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class GenericPopUp: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var filledBtn: UIButton!
    
    // MARK:- Variables
    var callBack : (() -> ())?
    
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
    func removeElements() {
        filledBtn.isHidden = true
        subtitleLbl.isHidden = true
        containerViewHeight.constant -= filledBtn.bounds.size.height
        containerViewHeight.constant -= subtitleLbl.bounds.size.height
        if view.bounds.size.height > 667.0 {
            containerViewHeight.constant -= 40
        }

        
    }
       private func addPropertiesAndStyling(){
             
        titleLbl.numberOfLines = 0
              let string2 = NSAttributedString(string: "Home", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 18)!])
                               filledBtn.setAttributedTitle(NSAttributedString(attributedString: string2), for: .normal)
                               filledBtn.setGradientBackgroundColor(colors: [ UIColor(red: 154/255.0, green: 154/255.0, blue: 198/255.0, alpha: 1.0), UIColor(red: 39/255.0, green: 65/255.0, blue: 143/255.0, alpha: 1.0)], axis: .vertical, cornerRadius: 25) { view in
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
           titleLbl.attributedText = titleString
                     
           cancelBtn.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        filledBtn.addTarget(self, action: #selector(btnCallBack), for: .touchUpInside)
          }
   
       @objc func dismissPopUp() {
           removeAnimate()
       }
    @objc func btnCallBack() {
        callBack?()
    }
       
    
    
    
}
