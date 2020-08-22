//
//  PaymentTitles.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 17/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
import Foundation

// MARK: - Welcome
struct PaymentTitles: Codable {
    let applicationStatusList: [PaymentType]?
    let responseCode: Int?
    let status: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case applicationStatusList = "application_status_list"
        case responseCode = "response_code"
        case status, message
    }
}

// MARK: - ApplicationStatusList
struct PaymentType: Codable {
    let paymentTypeID, paymentTypeTitle: String?

    enum CodingKeys: String, CodingKey {
        case paymentTypeID = "payment_type_id"
        case paymentTypeTitle = "payment_type_title"
    }
}
