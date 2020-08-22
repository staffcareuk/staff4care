//
//  JobsServices.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

class JobServices {
    
    static let shared = JobServices()
    
    // Available Jobs / Latest Jobs
    
    func getAvailableJobs(urlString: String ,completion: @escaping (Result<Jobs,GenericResponseError>) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
        request.addValue(userToken,  forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            do {
                print(data)
                let jobsResponse = try JSONDecoder().decode(Jobs.self, from: data)
                print(jobsResponse)
                completion(.success(jobsResponse))
                
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // Post Job / Create Job
    
    func postJob(urlString: String,parameters: [String:Any], completion: @escaping (Result<CreateJobModel,GenericResponseError>) -> Void) {
             
           guard let url = URL(string: urlString) else {return}
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
           request.addValue(userToken,  forHTTPHeaderField: "Authorization")
           
           guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
           request.httpBody = httpBody
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               
               guard let data = data, error == nil else {
                   if let error = error as NSError?, error.domain == NSURLErrorDomain {
                       completion(.failure(.domainError))
                   }
                   return
               }
               
               do {
                   print(data)
                   let response = try JSONDecoder().decode(CreateJobModel.self, from: data)
                   print(response)
                   completion(.success(response))
                   
                   
                   
               } catch {
                       completion(.failure(.decodingError))
               }
               
           }.resume()
           
       }
    
     // Get Nearest Jobs
    
    func getNearestJobs(urlString: String ,completion: @escaping (Result<Jobs,GenericResponseError>) -> Void) {
          
          guard let url = URL(string: urlString) else {return}
          var request = URLRequest(url: url)
          
          request.httpMethod = "GET"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
          request.addValue(userToken,  forHTTPHeaderField: "Authorization")
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              
              guard let data = data, error == nil else {
                  if let error = error as NSError?, error.domain == NSURLErrorDomain {
                      completion(.failure(.domainError))
                  }
                  return
              }
              do {
                  print(data)
                  let jobsResponse = try JSONDecoder().decode(Jobs.self, from: data)
                  print(jobsResponse)
                  completion(.success(jobsResponse))
                  
              } catch {
                  completion(.failure(.decodingError))
              }
          }.resume()
      }
      
    func getNearbyStaff(urlString: String ,completion: @escaping (Result<NearbyStaff,GenericResponseError>) -> Void) {
             
             guard let url = URL(string: urlString) else {return}
             var request = URLRequest(url: url)
             
             request.httpMethod = "GET"
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
             request.addValue(userToken,  forHTTPHeaderField: "Authorization")
             
             URLSession.shared.dataTask(with: request) { data, response, error in
                 
                 guard let data = data, error == nil else {
                     if let error = error as NSError?, error.domain == NSURLErrorDomain {
                         completion(.failure(.domainError))
                     }
                     return
                 }
                 do {
                     print(data)
                     let staff = try JSONDecoder().decode(NearbyStaff.self, from: data)
                     print(staff)
                     completion(.success(staff))
                     
                 } catch {
                     completion(.failure(.decodingError))
                 }
             }.resume()
         }
         
}
