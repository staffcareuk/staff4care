//
//  JobsModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
struct Jobs: Codable {
    let jobsList: [JobsList]?
    let responseCode: Int?
    let status: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case jobsList = "jobs_list"
        case responseCode = "response_code"
        case status, message
    }
}

// MARK: - JobsList
struct JobsList: Codable {
    let jobID, jobTitle, jobCategory, jobSubCategory: String?
    let jobDate, jobFrom, jobTo, jobInstructions: String?
    let userID, createdDate, modifiedDate, status: String?
    let hospitalName, contactName, contactDesignation, contactEmail: String?
    let contactPhone, dateOfBirth, postcode, address: String?
    let registrationNo, nextOfKin, cardFullName, cardNumber: String?
    let expiryDate, cvc, gendar , longitude , latitude , amount , payment_type: String?

    enum CodingKeys: String, CodingKey {
        case jobID = "job_id"
        case jobTitle = "job_title"
        case jobCategory = "job_category"
        case jobSubCategory = "job_sub_category"
        case jobDate = "job_date"
        case jobFrom = "job_from"
        case jobTo = "job_to"
        case jobInstructions = "job_instructions"
        case userID = "user_id"
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case status
        case hospitalName = "hospital_name"
        case contactName = "contact_name"
        case contactDesignation = "contact_designation"
        case contactEmail = "contact_email"
        case contactPhone = "contact_phone"
        case dateOfBirth = "date_of_birth"
        case postcode, address
        case registrationNo = "registration_no"
        case nextOfKin = "next_of_kin"
        case cardFullName = "card_full_name"
        case cardNumber = "card_number"
        case expiryDate = "expiry_date"
        case cvc, gendar, longitude , latitude , amount , payment_type
    }
}
