//
//  ViewJobsViewModel.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
//protocol GetJobsProtocol: class {
//    func getJobsSuccess()
//    func getJobsFailed ()
//}

class ViewJobsViewModel {

    // MARK:- Variables
    
    var jobsUrl   = "https://api.bluenee.co.uk/cig/index.php/api/jobs/list/"
   // weak var getJobsDelegate: GetJobsProtocol?
    var latestJobs: Jobs?
    
    // MARK:- Methods
    
    // MARK:- Networking Methods
    func getAvailableJobs() {
          JobServices.shared.getAvailableJobs(urlString: jobsUrl) { result in
              switch result {
              case .success(let jobs):
                  print("Jobs :: " , jobs)
                  self.latestJobs = jobs
                  //self.getJobsDelegate?.getJobsSuccess()
              case .failure(let reason):
                  print("Reason :: " , reason)
                  //self.getJobsDelegate?.getJobsFailed()
              }
          }
      }
}
