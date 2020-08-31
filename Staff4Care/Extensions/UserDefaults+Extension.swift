//
//  UserDefaults+Extension.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
