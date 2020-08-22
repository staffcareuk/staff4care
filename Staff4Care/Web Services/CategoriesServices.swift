//
//  CategoriesServices.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 25/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

class CategoriesServices {
    
    static let shared = CategoriesServices()
    
    // Get Catrgories
    func getCategories(urlString: String ,completion: @escaping (Result<Categories,GenericResponseError>) -> Void) {
        
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
                let categoriesResponse = try JSONDecoder().decode(Categories.self, from: data)
                print(categoriesResponse)
                completion(.success(categoriesResponse))

            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
       
    
    func getSubCategories(urlString: String ,completion: @escaping (Result<Categories,GenericResponseError>) -> Void) {
           
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
                   let categoriesResponse = try JSONDecoder().decode(Categories.self, from: data)
                   print(categoriesResponse)
                   completion(.success(categoriesResponse))

               } catch {
                   completion(.failure(.decodingError))
               }
           }.resume()
       }
    
    
    // Get Payment Types
    func getPaymentTypes(urlString: String ,completion: @escaping (Result<PaymentTitles,GenericResponseError>) -> Void) {
             
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
                     let titles = try JSONDecoder().decode(PaymentTitles.self, from: data)
                     print(titles)
                     completion(.success(titles))

                 } catch {
                     completion(.failure(.decodingError))
                 }
             }.resume()
         }
          
    
    
    
    
    
    
}
