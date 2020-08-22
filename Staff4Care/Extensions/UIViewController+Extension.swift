//
//  UIViewController+Extension.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 11/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
import UIKit
protocol StringConvertible {
    var rawValue: String {get}
}

protocol Instantiable: class {
    static var storyboardName: StringConvertible {get}
}

extension Instantiable {
    static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper()
    }

    private static func instantiateFromStoryboardHelper<T>() -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

//MARK: -

extension String: StringConvertible { // allow string as storyboard name
    var rawValue: String {
        return self
    }
}
