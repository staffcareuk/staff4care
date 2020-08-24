//
//  LoginServices.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
// MARK: - LoginResponse
struct LoginResponse: Codable {
    let userID, email, role, verificationCode: String?
    let verifyAccount, profileComplete, phoneNumber, username: String?
    let status: Bool?
    let message: String?
    let responseCode: Int?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, role
        case verificationCode = "verification_code"
        case verifyAccount = "verify_account"
        case profileComplete = "profile_complete"
        case phoneNumber = "phone_number"
        case username, status, message
        case responseCode = "response_code"
        case token = "Token"
    }
}
struct SignUpResponse: Codable {
    let username, email, password, phoneNumber: String?
    let role: String?
    let verificationCode: Int?
    let token: String?
    let userID, responseCode: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case username, email, password
        case phoneNumber = "phone_number"
        case role
        case verificationCode = "verification_code"
        case token = "Token"
        case userID = "user_id"
        case responseCode = "response_code"
        case message
    }
}
struct RegisterResponse: Codable {
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
struct VerifyCodeResponse: Codable {
    let message, token: String?
    let status: Bool?
    let responseCode: Int?

    enum CodingKeys: String, CodingKey {
        case message, token, status
        case responseCode = "response_code"
    }
}
struct CareProviderRegisterResponse: Codable {
    let message, userID: String?
    let status: Bool?
    let responseCode, profileComplete: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case status
        case responseCode = "response_code"
        case profileComplete = "profile_complete"
    }
}



enum GenericResponseError: Error {
    //case invalidUser(reason: InvalidUserReasons)
    case invalidUser
    case domainError
    case networkError
    case decodingError
}
enum InvalidUserReasons: String{
    case requireAllFields
    case wrongCredentials
    case userAlreadyExists
}
class LoginServices {
    
    static let shared = LoginServices()
    
    func loginUser(urlString: String,parameters: [String:Any], completion: @escaping (Result<LoginResponse,GenericResponseError>) -> Void) {
          
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
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
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                print(loginResponse.token)
                completion(.success(loginResponse))
                
                
                
            } catch {
                    completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
    
       func signupUser(urlString: String,parameters: [String:Any],completion: @escaping (Result<SignUpResponse,GenericResponseError>) -> Void) {
             
           guard let url = URL(string: urlString) else {return}
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
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
                            let signupResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                              print(signupResponse)
                             completion(.success(signupResponse))
//                              if signupResponse.responceCode == "200" {
//                                  completion(.success(signupResponse))
//                              }
//                              else {
//                                  completion(.failure(.invalidUser))
//                              }
                              
                          } catch {
                                  completion(.failure(.decodingError))
                          }
                          
                      }.resume()
           
       }
    
    
       func registerUser(urlString: String,parameters: [String:Any],completion: @escaping (Result<RegisterResponse,GenericResponseError>) -> Void) {
                    
                  guard let url = URL(string: urlString) else {return}
                  var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
        print("Token :: " , userToken)
        request.addValue(userToken,  forHTTPHeaderField: "Token")
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
                                   let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                                     print(registerResponse)
                                    completion(.success(registerResponse))
       //                              if signupResponse.responceCode == "200" {
       //                                  completion(.success(signupResponse))
       //                              }
       //                              else {
       //                                  completion(.failure(.invalidUser))
       //                              }
                                     
                                 } catch {
                                         completion(.failure(.decodingError))
                                 }
                                 
                             }.resume()
                  
              }
    func verifyCode(urlString: String,parameters: [String:Any],completion: @escaping (Result<VerifyCodeResponse,GenericResponseError>) -> Void) {
                       
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
                                      let registerResponse = try JSONDecoder().decode(VerifyCodeResponse.self, from: data)
                                        print(registerResponse)
                                       completion(.success(registerResponse))
          //                              if signupResponse.responceCode == "200" {
          //                                  completion(.success(signupResponse))
          //                              }
          //                              else {
          //                                  completion(.failure(.invalidUser))
          //                              }
                                        
                                    } catch {
                                            completion(.failure(.decodingError))
                                    }
                                    
                                }.resume()
                     
                 }
    
    
    
    
    
    
    
    
    
       func registerCareProvider(urlString: String,parameters: [String:Any],completion: @escaping (Result<CareProviderRegisterResponse,GenericResponseError>) -> Void) {
                    
                  guard let url = URL(string: urlString) else {return}
                  var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("14digital@12345",  forHTTPHeaderField: "x-api-key")
        print("Token :: " , userToken)
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
                                   let registerResponse = try JSONDecoder().decode(CareProviderRegisterResponse.self, from: data)
                                     print(registerResponse)
                                    completion(.success(registerResponse))
       //                              if signupResponse.responceCode == "200" {
       //                                  completion(.success(signupResponse))
       //                              }
       //                              else {
       //                                  completion(.failure(.invalidUser))
       //                              }
                                     
                                 } catch {
                                         completion(.failure(.decodingError))
                                 }
                                 
                             }.resume()
                  
              }
    
    
    
    
    
    
      
    
    
}
