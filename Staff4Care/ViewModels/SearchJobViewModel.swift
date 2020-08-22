//
//  SearchJobViewModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
protocol SearchJobProtocol: class {
    func getCategoiresSuccess()
    func getCategoriesFailed()
    func getSubCategoriesSuccess()
    func getSubCategoriesFailed()
    func getJobsSuccess()
    func getJobsFailed ()
    func locationUpdated ()
    func locationUpdateFailed ()
    func gotNearbyStaff()
    func failedNearbyStaff()
}

struct ClientModel {
    var imageName: String = ""
    var clientName: String = ""
}

class SearchJobViewModel {
    
    // MARK:- Variables
    var clientModel: [ClientModel] = [ClientModel(imageName: "carehome-image",clientName: "Care Homes") ,ClientModel( imageName: "residential-care",clientName: "Residential Care") ,ClientModel( imageName: "individual-care" , clientName: "Individual Care"), ClientModel(imageName: "hospital-image" , clientName: "Hospitals") ,ClientModel( imageName: "hospices-image", clientName: "Hospices" ), ClientModel(imageName: "clinic-image",clientName: "Clinics")]
    
    var categoriesModel: Categories?
    var subcategoriesModel: Categories?
    weak var searchJobDelegate:SearchJobProtocol?
    var getJobsUrl        = "https://api.bluenee.co.uk/cig/index.php/api/jobs/list/"
    var nearestJobsURL    = "https://api.bluenee.co.uk/cig/index.php/api/staff/nearestjobs/"
    var updateLocationURL = "https://api.bluenee.co.uk/cig/index.php/api/staff/location/"
    var nearestStaffURL   = "https://api.bluenee.co.uk/cig/index.php/api/jobs/nearbystaff/"
    var allJobs: Jobs?
    var nearestJobs: Jobs?
    var nearbyStaff: NearbyStaff?
    var numberOfMiles = "500"
    
    
    // MARK:- Networking Methods
    
    // Get Categories
    func getCategoriesList(url: String) {
        CategoriesServices.shared.getCategories(urlString: url) { result in
            switch result {
            case .success(let categories):
                print("Categories :: " , categories)
                self.categoriesModel = categories
                self.searchJobDelegate?.getCategoiresSuccess()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.getCategoriesFailed()
            }
        }
    }
    
    // Get SubCategories
    
    func getSubCategoriesList(url: String) {
        CategoriesServices.shared.getSubCategories(urlString: url) { result in
            switch result {
            case .success(let categories):
                print("SubCategories :: " , categories)
                self.subcategoriesModel = categories
                self.searchJobDelegate?.getSubCategoriesSuccess()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.getSubCategoriesFailed()
            }
        }
    }
    
    // Get all Jobs or jobs against specific hospital
    
    func getAvailableJobs() {
        JobServices.shared.getAvailableJobs(urlString: getJobsUrl) { result in
            switch result {
            case .success(let jobs):
                print("Jobs :: " , jobs)
                self.allJobs = jobs
                self.searchJobDelegate?.getJobsSuccess()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.getJobsFailed()
            }
        }
    }
    
    // Get Nearest Jobs based on radius
    func getNearestJobs(latitude:String,longitude:String) {
        if let userID = loggedUser?.userID {
            nearestJobsURL += "11"
            nearestJobsURL += "/" + numberOfMiles
//            nearestJobsURL += "/" + latitude + "/" + longitude
             nearestJobsURL += "/" + "73.018899" + "/" + "33.619799"
            
        }
        print(nearestJobsURL)
        JobServices.shared.getNearestJobs(urlString: nearestJobsURL) { result in
            switch result {
            case .success(let jobs):
                print("Jobs :: " , jobs)
                self.nearestJobs = jobs
                self.searchJobDelegate?.getJobsSuccess()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.getJobsFailed()
            }
            
        }
    }
    func getNearbyStaff() {
        nearestStaffURL += numberOfMiles
        nearestStaffURL += "/" + "73.018899" + "/" + "33.619799"
        JobServices.shared.getNearbyStaff(urlString: nearestStaffURL) { result in
            switch result {
            case .success(let staff):
                print("Staff :: " , staff)
                self.nearbyStaff = staff
                self.searchJobDelegate?.gotNearbyStaff()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.failedNearbyStaff()
            }
        }
                    
                
        
    }
     
    // Update Location of Staff
    
    func updateStaffLocation(params: [String:Any]) {
        if let Id = loggedUser?.userID {
            updateLocationURL += Id
        }
        LocationServices.shared.updateStaffLocation(urlString: updateLocationURL, parameters: params) { result in
            switch result {
            case .success(let response):
                print("Response :: " , response)
                self.searchJobDelegate?.locationUpdated()
            case .failure(let reason):
                print("Reason :: " , reason)
                self.searchJobDelegate?.locationUpdateFailed()
                
            }
        }
    }
    
  

    
   
}
