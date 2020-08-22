//
//  CustomButton.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 16/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
@IBDesignable
class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
    override init(frame: CGRect) {
         super.init(frame: frame)
       }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
       }

    func setup(applyGradient: Bool,title: String,rgb1: (CGFloat,CGFloat,CGFloat)? = nil , rgb2: (CGFloat,CGFloat,CGFloat)? = nil) {
        if applyGradient{
            let gradient:CAGradientLayer = CAGradientLayer()
            if let colorOne = rgb1 , let colorTwo = rgb2 {
                let colorTop = UIColor(red: colorOne.0/255.0, green: colorOne.1/255.0, blue: colorOne.2/255.0, alpha: 1.0).cgColor
                let colorBottom = UIColor(red: colorTwo.0/255.0, green: colorTwo.1/255.0, blue: colorTwo.2/255.0, alpha: 1.0).cgColor

                            gradient.colors = [colorTop, colorBottom]
                            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                           gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                           gradient.frame = self.bounds
                           self.clipsToBounds = true
                           self.layer.cornerRadius = self.frame.size.height / 2
                           self.layer.insertSublayer(gradient, at: 0)
            }
           
        } else {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.size.height / 2
         
            
        }
         
       }
    func addRoundedBorder(shadowColor: UInt) {
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.white.cgColor
     self.layer.shadowColor = UIColor.init(rgb: shadowColor).cgColor
     self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
     self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
     self.layer.masksToBounds = false
     self.layer.cornerRadius = 30.0
    
    }

  

}
extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
extension UIButton
{
    func applyGradientt(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.size.height / 2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
