//
//  MapsContentViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 09/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import GooglePlaces
import IQKeyboardManagerSwift
protocol SetPlaceOnMap : class{
    func getLocationfromPlace(latitude: Double,longitude: Double)
    func cancelTapped()
    func editingBegin()
}
class MapsContentViewController: UIViewController {
    
     // MARK:- IBOutlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placesTableView: UITableView!

    // MARK:- Variables
    var places = ["Los Angeles" , "Chicago" , "Nevada" , "Delaware" , "Ohio"]
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    weak var locationDelegate: SetPlaceOnMap?


    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.delegate = self
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        searchBar.tintColor = .white
        placesTableView.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        placesTableView.dataSource = self
        searchBar.searchTextField.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
        
        

    }
    // MARK:- Methods
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
       
    }
    
     @objc func searchPlaceFromGoogle(_ textField:UITextField) {
      
      if let searchQuery = textField.text {
          var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key= AIzaSyAktact94cs-v3cz9IVe2naZBIFt_NhFcY"
          strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
          
          var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
          urlRequest.httpMethod = "GET"
          let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
              if error == nil {
                  
                  if let responseData = data {
                  let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                      
                      if let dict = jsonDict as? Dictionary<String, AnyObject>{
                          
                          if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                              print("json == \(results)")
                              self.resultsArray.removeAll()
                              for dct in results {
                                  self.resultsArray.append(dct)
                              }
                              
                              DispatchQueue.main.async {
                               self.placesTableView.reloadData()
                              }
                              
                          }
                       
                      }
                     
                  }
              } else {
                  //we have error connection google api
              }
          }
          task.resume()
      }
      }
      






    // MARK:- IBAction Methods





}

// MARK:- SearchBar Delegate


extension MapsContentViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Tapped")
        searchBar.resignFirstResponder()
        locationDelegate?.cancelTapped()

        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //self.move(to: .half, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //self.move(to: .full, animated: true)
        locationDelegate?.editingBegin()
    }
}

extension MapsContentViewController: UITableViewDelegate , UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return resultsArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "placecell")
          
        if indexPath.row < resultsArray.count {
            let place = self.resultsArray[indexPath.row]
                   cell?.textLabel?.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
//            cell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rowTapped)))
        }
              
           
           return cell!
       }
    @objc func rowTapped(){
        
        
    }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //tableView.deselectRow(at: indexPath, animated: true)
         locationDelegate?.cancelTapped()
        searchBar.resignFirstResponder()

           let place = self.resultsArray[indexPath.row]
           if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
               if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                   if let latitude = location["lat"] as? Double {
                       if let longitude = location["lng"] as? Double {
                        locationDelegate?.getLocationfromPlace(latitude: latitude, longitude: longitude)

                       }
                   }
               }
           }
        tableView.deselectRow(at: indexPath, animated: true)
       }


}
