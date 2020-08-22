//
//  CreateJobResponseModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
struct CreateJobModel: Codable {
    let message, userID: String?
    let status: Bool?
    let responseCode, profileComplete: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case status
        case responseCode = "response_code"
        case profileComplete = "profile_complete"
    }
}
