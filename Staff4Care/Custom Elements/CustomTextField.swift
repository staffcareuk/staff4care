//
//  CustomTextField.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 23/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
import UIKit

protocol DesignableTextFieldDelegate: UITextFieldDelegate {
    func textFieldIconClicked(btn:UIButton)
    func textFieldRightButtonClicked(btn:UIButton)
}

@IBDesignable
class CustomTextField: UITextField , UITextFieldDelegate{

    override init(frame: CGRect) {
           super.init(frame: frame)
        self.delegate = self
       }
       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        self.delegate = self
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.addTarget(self, action: #selector(textFieldDidChange(_:)),
        for: .editingChanged)
        
       


       }
    //Delegate when image/icon is tapped.
    private var myDelegate: DesignableTextFieldDelegate? {
        get { return delegate as? DesignableTextFieldDelegate }
    }
    

    @objc func buttonClicked(btn: UIButton){
        self.myDelegate?.textFieldIconClicked(btn: btn)
    }
    @objc func buttonClickedRight(btn: UIButton){
         self.myDelegate?.textFieldRightButtonClicked(btn: btn)
     }

    //Padding images on left
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }

    //Padding images on Right
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }

    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var leadingImage: UIImage? { didSet { updateView() }}
    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { updateView() }}
    @IBInspectable var imageColor: UIColor = UIColor.white { didSet { updateView() }}
    @IBInspectable var rtl: Bool = false { didSet { updateView() }}
    @IBInspectable var trailingImage: UIImage? { didSet { updateView() }}
    var previousPlaceHolder = ""

    func addAttributedPlaceholder(font: UIFont , color: UIColor , placeholder: String) {
        
        let placeholder = placeholder //There should be a placeholder set in storyboard or elsewhere string or pass empty
        self.previousPlaceHolder = placeholder
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color , NSAttributedString.Key.font: font])
    }
    func updateView() {
        
                       
        rightViewMode = UITextField.ViewMode.never
        rightView = nil
        leftViewMode = UITextField.ViewMode.never
        leftView = nil

        if let image = leadingImage {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            
        
            button.setImage(image, for: .normal)
            button.setTitleColor(UIColor.clear, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(btn:)), for: UIControl.Event.touchDown)
            button.isUserInteractionEnabled = true

            if rtl {
                rightViewMode = UITextField.ViewMode.always
                rightView = button
            } else  {
                leftViewMode = UITextField.ViewMode.always
                leftView = button
            }
        }
        if let image2 = trailingImage {
            let button2 = UIButton(type: .custom)
            button2.frame = CGRect(x: self.frame.width - 20, y: 0, width: 20, height: 20)
            
            button2.setImage(image2, for: .normal)
            button2.setTitleColor(UIColor.clear, for: .normal)
            button2.addTarget(self, action: #selector(buttonClickedRight(btn:)), for: UIControl.Event.touchDown)
            button2.isUserInteractionEnabled = true
            rightViewMode = UITextField.ViewMode.always
            rightView = button2
            
        }
       

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
     func styleTextField(_ textfield:UITextField) {
          
          // Create the bottom line
          let bottomLine = CALayer()
          
          bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 5, width: textfield.frame.width - 40, height: 2)
          
         // bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
          
        bottomLine.backgroundColor = UIColor.green.cgColor
          // Remove border on text field
          textfield.borderStyle = .none
          
          // Add the line to the text field
          textfield.layer.addSublayer(bottomLine)
          
      }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            UIView.animate(withDuration: 0.5) {
                textField.layer.borderColor = UIColor.red.cgColor
                self.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 12)!, color: UIColor.red, placeholder: "This field is required")
                

            }
        }
        else {
            if textField.tag == 1 {
                     let valid = self.isValidEmail(textField.text!)
                if !valid {
                   UIView.animate(withDuration: 0.5) {
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.text = ""
                    self.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 12)!, color: UIColor.red, placeholder: "Not a Valid Email")
                        

                    }
                                  
                }
                else {
                     textField.layer.borderColor = UIColor.clear.cgColor
                                   self.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 12)!, color: UIColor.red, placeholder: "Enter your email")
                }
               
                      
                  }
        }

      
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            textField.layer.borderColor = UIColor.clear.cgColor
            self.addAttributedPlaceholder(font: UIFont(name: Fonts.Book, size: 14)!, color: UIColor.init(rgb: 0xD1D1D1), placeholder: self.previousPlaceHolder)
            
            
        }
        
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
   
    
}
