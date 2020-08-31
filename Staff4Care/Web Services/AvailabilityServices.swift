//
//  AvailabilityServices.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 26/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

class AvailabilityServices {
    static let shared = AvailabilityServices()
    
    // Get List of Shifts
    func getShifts(urlString: String ,completion: @escaping (Result<AvailabilityShiftsModel,GenericResponseError>) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            do {
                print(data)
                let shifts = try JSONDecoder().decode(AvailabilityShiftsModel.self, from: data)
                print(shifts)
                completion(.success(shifts))

            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
