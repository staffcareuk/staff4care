//
//  Constants+Enums.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 18/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation

struct Constants {
    static var notification_token = ""
    static var UDID = ""
    static let baseUrl = "https://api.bluenee.co.uk/cig/index.php/api/"
    static var user_id = ""
}


class Fonts {
    static let Book = "ITCAvantGardeStd-Bk"
    static let Demi = "ITCAvantGardeStd-Demi"
    static let Medium = "ITCAvantGardeStd-Md"
}

enum StoryboardName: String, StringConvertible {
       case Login = "LoginScreens"
       case Registration = "Registration"
       case searchJob = "SearchJob"
       case userProfile = "UserProfile"
       case Availability = "Availability"
       case jobCalendar = "JobCalendar"
       case Payments = "Payments"
       case travelHistory = "TravelHistory"
       case PopUpView = "PopUpView"
     
   }
var userToken = ""
var loggedUser: LoginResponse?
var signedupUser: SignUpResponse?
