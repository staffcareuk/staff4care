//
//  CategoriesResponseModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 25/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
struct Categories: Codable {
    let categoriesList: [Category]?
       let responseCode: Int?
       let status: Bool?
       let message: String?

       enum CodingKeys: String, CodingKey {
           case categoriesList = "categories_list"
           case responseCode = "response_code"
           case status, message
       }
}

// MARK: - CategoriesList
struct Category: Codable {
    let categoryID, categoryTitle: String?
    let categoryImage: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryTitle = "category_title"
        case categoryImage = "category_image"
    }
}

//typealias Categor = [WelcomeElement]
