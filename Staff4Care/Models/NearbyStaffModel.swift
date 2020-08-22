//
//  NearbyStaffModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 18/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Welcome
struct NearbyStaff: Codable {
    let staffList: [StaffList]?
    let responseCode: Int?
    let status: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case staffList = "staff_list"
        case responseCode = "response_code"
        case status, message
    }
}

// MARK: - StaffList
struct StaffList: Codable {
    let userID, name, fatherName, designation: String?
    let company, dateOfBirth, postcode, longitude: String?
    let latitude, experience, registrationNo, ethnicBackground: String?
    let habit, address, sortCode1, sortCode2: String?
    let sortCode3, accountNo, bankName, createdDate: String?
    let modifiedDate, gendar, distance: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case fatherName = "father_name"
        case designation, company
        case dateOfBirth = "date_of_birth"
        case postcode, longitude, latitude, experience
        case registrationNo = "registration_no"
        case ethnicBackground = "ethnic_background"
        case habit, address
        case sortCode1 = "sort_code_1"
        case sortCode2 = "sort_code_2"
        case sortCode3 = "sort_code_3"
        case accountNo = "account_no"
        case bankName = "bank_name"
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case gendar, distance
    }
}
