//
//  CreateFindJobsViewModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
protocol DropDownCategoriesProtocol: class {
    func gotCategoriesforDD()
    func gotSubCategoriesforDD()
    func categoriesforDropDownFailed()
    func subcategoriesforDropDownFailed()
    func gotTitles()
    func titlesFailed()
    
}
class CreateFindJobsViewModel {
    // MARK:- Variables
    var postJobUrl = "https://api.bluenee.co.uk/cig/index.php/api/jobs/add/"
    var paymentTypesURL = "https://api.bluenee.co.uk/cig/index.php/api/applications/payment_titles"
    var categoriesDropDown: Categories?
    var subcategoriesDropDown: Categories?
    var paymentTypes: PaymentTitles?
    weak var dropDownDelegate: DropDownCategoriesProtocol?
    
    
    // MARK:- Networking Methods
    func postJob(params: [String:Any]) {
        if let hospitalID = loggedUser?.userID {
          postJobUrl += hospitalID
        }
        JobServices.shared.postJob(urlString: postJobUrl, parameters: params) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let reason):
                print(reason)
            }
        }
    }
    
       // Get Categories
       func getCategoriesList(url: String) {
           CategoriesServices.shared.getCategories(urlString: url) { result in
               switch result {
               case .success(let categories):
                   print("Categories :: " , categories)
                   self.categoriesDropDown = categories
                   self.dropDownDelegate?.gotCategoriesforDD()
               case .failure(let reason):
                   print("Reason :: " , reason)
                   self.dropDownDelegate?.categoriesforDropDownFailed()
               }
           }
       }
       
       // Get SubCategories
       
       func getSubCategoriesList(url: String) {
           CategoriesServices.shared.getSubCategories(urlString: url) { result in
               switch result {
               case .success(let categories):
                   print("SubCategories :: " , categories)
                   self.subcategoriesDropDown = categories
                   self.dropDownDelegate?.gotSubCategoriesforDD()
               case .failure(let reason):
                   print("Reason :: " , reason)
                   self.dropDownDelegate?.subcategoriesforDropDownFailed()
               }
           }
       }
    // Get Payment Types
    func getPaymentTypes(){
        CategoriesServices.shared.getPaymentTypes(urlString: paymentTypesURL) { result in
            switch result {
            case .success(let titles):
                print(titles.applicationStatusList)
                self.paymentTypes = titles
                self.dropDownDelegate?.gotTitles()
            case .failure(let reason):
                print(reason)
                self.dropDownDelegate?.titlesFailed()
            }
        }
    }
    
       
}
