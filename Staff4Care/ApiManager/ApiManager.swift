
import Foundation
import UIKit
import Alamofire

typealias DefaultAPIFailureClosure = (String) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void

typealias DefaultAPISuccessClosureData = (Data) -> Void

typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void

class ApiManager: NSObject {
    //MARK: Create basic header
    static func getBasicAuthorizationHeader() -> HTTPHeaders {
        let header: HTTPHeaders = [
            "x-api-key": "14digital@12345",
            "Authorization" : userToken
        ]
        
        
        return header
    }
    
    static func getBasisHeader () ->HTTPHeaders {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "X-Requested-With" : "XMLHttpRequest"]
        return headers
    }
    
    static func postRequestWithBasicHeader(route: URL,param: Parameters,
                                           success:@escaping DefaultAPISuccessClosureData,
                                           failure:@escaping DefaultAPIFailureClosure){
        
        
        Alamofire.request(route, method:.post, parameters:param, encoding: JSONEncoding.default, headers:getBasicAuthorizationHeader()).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    print(response.result)
                    if let jsonData = response.data{
                        success(jsonData)
                    } else {
                        failure("Error occured")
                    }
                } catch let err {
                    print("Err", err)
                    failure(err.localizedDescription)
                }
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
        }
    }
    
    
    static func postRequestWithOutHeader(route: URL,param: Parameters,
                                         success:@escaping DefaultAPISuccessClosureData,
                                         failure:@escaping DefaultAPIFailureClosure){
        
        
        Alamofire.request(route, method:.post, parameters:param, headers:nil).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    print(response)
                    if let jsonData = response.data{
                        success(jsonData)
                    } else {
                        failure("Error occured")
                    }
                } catch let err {
                    print("Err", err)
                    failure(err.localizedDescription)
                }
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
        }
    }
    
    
    static func postRequestWithJson(route: URL,param: Parameters,
                                    success:@escaping DefaultAPISuccessClosureData,
                                    failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method:.post, parameters:param,encoding: JSONEncoding.default, headers:getBasicAuthorizationHeader()).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    print(response)
                    if let jsonData = response.data{
                        success(jsonData)
                    } else {
                        failure("Error occured")
                    }
                } catch let err {
                    print("Err", err)
                    failure(err.localizedDescription)
                }
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
        }
    }
    
    static func getRequestWithData(route: URL,param: Parameters,
                                   success:@escaping DefaultAPISuccessClosureData,
                                   failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method:.get, parameters:param, headers:getBasicAuthorizationHeader()).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    print(response.result)
                    if let jsonData = response.data{
                        success(jsonData)
                    } else {
                        failure("Error occured")
                    }
                } catch let err {
                    print("Err", err)
                    failure(err.localizedDescription)
                }
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
        }
    }
    
    
    static func postRequestWithReturnData(route: URL,param: Parameters,
                                          success:@escaping DefaultAPISuccessClosureData,
                                          failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .post, parameters: param, encoding: JSONEncoding.default , headers: getBasicAuthorizationHeader()).responseJSON(completionHandler: {
            response in
            
            switch response.result {
            case .success:
                do {
                    print(response)
                    if let jsonData = response.data{
                        success(jsonData)
                    } else {
                        failure("Error occured")
                    }
                } catch let err {
                    print("Err", err)
                    failure(err.localizedDescription)
                }
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
            }
            
        })
        //
        //        Alamofire.request(route, method:.post, parameters:param, headers:nil).responseJSON { response in
        //            switch response.result {
        //            case .success:
        //                do {
        //                    print(response)
        //                    if let jsonData = response.data{
        //                        success(jsonData)
        //                    } else {
        //                        failure("Error occured")
        //                    }
        //                } catch let err {
        //                    print("Err", err)
        //                    failure(err.localizedDescription)
        //                }
        //            case .failure(let error):
        //                print(error)
        //                failure(error.localizedDescription)
        //            }
        //        }
    }
    
    
    // MARK :- post request for image
    
    static func postRequestWithMultipart(route: URL, parameters: Parameters,
                                         success:@escaping DefaultAPISuccessClosureData,
                                         failure:@escaping DefaultAPIFailureClosure){
        
        print(route.absoluteString)
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.post, headers: nil)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            var subParameters = Dictionary<String, AnyObject>()
            let keys: Array<String> = Array(parameters.keys)
            let values = Array(parameters.values)
            
            for i in 0..<keys.count {
                subParameters[keys[i]] = values[i] as AnyObject
            }
            
            for (key, value) in subParameters {
                
                if let data:Data = value as? Data {
                    print(key)
                    multipartFormData.append(data, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                
            }
            
        }, with: URLSTR, encodingCompletion: {result in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print(response)
                    guard response.result.error == nil else{
                        
                        failure(response.result.error?.localizedDescription ?? "")
                        
                        return;
                    }
                    
                    if let value = response.result.value {
                        print (value)
                        do {
                            if let jsonData = response.data{
                                print(response)
                                success(jsonData)
                            } else {
                                failure("Error occured")
                            }
                        }
                    }
                }
            case .failure(let encodingError):
                failure(encodingError.localizedDescription)
            }
        })
    }
}
