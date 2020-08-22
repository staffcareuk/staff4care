//
//  CALayer+Extension.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 05/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
extension CALayer {
    
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        shadowPath = UIBezierPath(rect: rect).cgPath
        
    }
}

