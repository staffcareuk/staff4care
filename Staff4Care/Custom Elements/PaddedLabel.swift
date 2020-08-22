//
//  PaddedLabel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 30/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//


import UIKit
class UILabelPadding: UILabel {

    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))

    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }

  required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      self.commonInit()

  }

  override init(frame: CGRect) {
      super.init(frame: frame)
      self.commonInit()
  }
  func commonInit(){
    self.layer.cornerRadius = self.frame.size.height/2
      self.clipsToBounds = true
    self.textColor = UIColor.lightGray
    self.setProperties(borderWidth: 1.0, borderColor:UIColor.lightGray)
  }
  func setProperties(borderWidth: Float, borderColor: UIColor) {
      self.layer.borderWidth = CGFloat(borderWidth)
    self.layer.borderColor = borderColor.cgColor
  }


}
class DynamicLabel: UILabel {
    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
       override func drawText(in rect: CGRect) {
           super.drawText(in: rect.inset(by: padding))

       }

       override var intrinsicContentSize : CGSize {
           let superContentSize = super.intrinsicContentSize
           let width = superContentSize.width + padding.left + padding.right
           let heigth = superContentSize.height + padding.top + padding.bottom
           return CGSize(width: width, height: heigth)
       }

}
class EditProfileLabel: UILabel {

    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))

    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }

  required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      self.commonInit()

  }

  override init(frame: CGRect) {
      super.init(frame: frame)
      self.commonInit()
  }
  func commonInit(){
    self.layer.cornerRadius = 12
      self.clipsToBounds = true
    self.textColor = UIColor.lightGray
    self.setProperties(borderWidth: 1.0, borderColor:UIColor(rgb: 0xDCDCDC))
  }
  func setProperties(borderWidth: Float, borderColor: UIColor) {
      self.layer.borderWidth = CGFloat(borderWidth)
    self.layer.borderColor = borderColor.cgColor
  }


}
