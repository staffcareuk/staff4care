//
//  UIView+Extension.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 17/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

extension UIView {
    func applyStylingProperties(foregoundColor: UIColor , shadowColor: UInt,shadowRadius: CGFloat? = nil,cornerRadius: CGFloat? = nil){
        // Set Shadow
    self.backgroundColor = foregoundColor
    self.layer.shadowColor = UIColor.init(rgb: shadowColor).cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = shadowRadius ?? 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    self.layer.shouldRasterize = true
    self.layer.cornerRadius = cornerRadius ?? 12
    self.layer.rasterizationScale = UIScreen.main.scale
    
    }

    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 1
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 10
   //   layer.cornerRadius = 12.0
      

      layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath

      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
  
}
extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    func updateShadow() {
          // layer.shadowPath = UIBezierPath(roundedRect: self.bounds,cornerRadius:8).cgPath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath

       }  
}
extension UIView {
    func separateShadowAndView(){
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 6.0

        // add the border to subview
        let borderView = UIView()
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = 10
     //   borderView.layer.borderColor = UIColor.black.cgColor
      //  borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        self.addSubview(borderView)
    }
}
extension UIView {

    enum axis {
        case vertical, horizontal, custom(angle: CGFloat)
    }

    func setGradientBackgroundColor(colors: [UIColor], axis: axis, cornerRadius: CGFloat? = nil, apply: ((UIView) -> ())? = nil) {
        layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
        self.layoutIfNeeded()

        let cgColors = colors.map { $0.cgColor }

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = cgColors
        gradient.name = "gradientLayer"
        gradient.locations = [0.0, 1.0]

        switch axis {
            case .horizontal:
                gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            case .custom(let angle):
                calculatePoints(for: angle, gradient: gradient)
            default:
                break
        }

        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)

        guard let cornerRadius = cornerRadius else { return }

        let circularPath = CGMutablePath()

        circularPath.move(to: CGPoint.init(x: cornerRadius, y: 0))
        circularPath.addLine(to: CGPoint.init(x: self.bounds.width - cornerRadius, y: 0))
        circularPath.addQuadCurve(to: CGPoint.init(x: self.bounds.width, y: cornerRadius), control: CGPoint.init(x: self.bounds.width, y: 0))
        circularPath.addLine(to: CGPoint.init(x: self.bounds.width, y: self.bounds.height - cornerRadius))
        circularPath.addQuadCurve(to: CGPoint.init(x: self.bounds.width - cornerRadius, y: self.bounds.height), control: CGPoint.init(x: self.bounds.width, y: self.bounds.height))
        circularPath.addLine(to: CGPoint.init(x: cornerRadius, y: self.bounds.height))
        circularPath.addQuadCurve(to: CGPoint.init(x: 0, y: self.bounds.height - cornerRadius), control: CGPoint.init(x: 0, y: self.bounds.height))
        circularPath.addLine(to: CGPoint.init(x: 0, y: cornerRadius))
        circularPath.addQuadCurve(to: CGPoint.init(x: cornerRadius, y: 0), control: CGPoint.init(x: 0, y: 0))


        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.red.cgColor
        self.layer.mask = maskLayer

        apply?(self)
    }

    func calculatePoints(for angle: CGFloat, gradient: CAGradientLayer) {

        var ang = (-angle).truncatingRemainder(dividingBy: 360)
        if ang < 0 { ang = 360 + ang }
        let n: CGFloat = 0.5

        switch ang {
            case 0...45, 315...360:
                let a = CGPoint(x: 0, y: n * tanx(ang) + n)
                let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
                gradient.startPoint = a
                gradient.endPoint = b
            case 45...135:
                let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
                let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
                gradient.startPoint = a
                gradient.endPoint = b
            case 135...225:
                let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
                let b = CGPoint(x: 0, y: n * tanx(ang) + n)
                gradient.startPoint = a
                gradient.endPoint = b
            case 225...315:
                let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
                let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
                gradient.startPoint = a
                gradient.endPoint = b
            default:
                let a = CGPoint(x: 0, y: n)
                let b = CGPoint(x: 1, y: n)
                gradient.startPoint = a
                gradient.endPoint = b

        }
    }

    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }

}
