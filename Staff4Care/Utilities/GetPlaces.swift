//
//  GetPlaces.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 11/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps
import Alamofire
import SwiftyJSON
func other() {
    var placesClient: GMSPlacesClient!

    var http = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=41.392788,-73.450949&radius=5000&type=restaurant&key=KEY_HERE"

    AF.request(http).responseJSON { (responseData) -> Void in
        if ((responseData.result) != nil) {
            let swiftyJsonVar = JSON(responseData.result)
            let results = swiftyJsonVar["results"].arrayValue

            let dispatchGroup = DispatchGroup()

            for result in results {
                let id = result["place_id"].stringValue

                dispatchGroup.enter()

                placesClient.lookUpPlaceID(id, callback: { (place, error) -> Void in
                   if let error = error {
                      print("Lookup place id query error: \(error.localizedDescription)")
                      dispatchGroup.leave()
                      return
                   }
                   guard let place = place else {
                      print("No place details for \(id)")
                      dispatchGroup.leave()
                      return
                   }

                  // self.arrayedName.append(place.name)
                   dispatchGroup.leave()
               })
           }
           dispatchGroup.notify(queue: DispatchQueue.global()) {
           //   self.tableView.reloadData()
           }
        }
    }
}
