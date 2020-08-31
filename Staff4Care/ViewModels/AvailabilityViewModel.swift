//
//  AvailabilityViewModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 26/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

class AvailabilityViewModel {
    
    // MARK:- Variables
    var availabilityURL = "https://api.bluenee.co.uk/cig/index.php/api/staff/shifts"
    
    
    
    // MARK:- Networking Methods
    
    func getShifts() {
        AvailabilityServices.shared.getShifts(urlString: availabilityURL) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let reason):
                print(reason)
            }
        }
    }
    
    
    
}
