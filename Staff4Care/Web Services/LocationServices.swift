//
//  LocationServices.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 07/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
struct UpdateLocationModel: Codable {
    let message, userID: String?
    let status: Bool?
    let responseCode: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case status
        case responseCode = "response_code"
    }
}


class LocationServices {
    static let shared = LocationServices()
    
    // Update Location API
      func updateStaffLocation(urlString: String,parameters: [String:Any], completion: @escaping (Result<UpdateLocationModel,GenericResponseError>) -> Void) {
              
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
                    let response = try JSONDecoder().decode(UpdateLocationModel.self, from: data)
                    print(response)
                    completion(.success(response))
                    
                    
                    
                } catch {
                        completion(.failure(.decodingError))
                }
                
            }.resume()
            
        }
    
    
}
