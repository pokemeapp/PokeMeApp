//
//  Constants.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Colors {
        static let Green = UIColor(rgb: 0x00ab00)
        static let ShadowGrey = UIColor(rgb: 0xa8a8a8)
    }
    
    struct Cells {
        static let RegistrationItemCell = "RegistrationItemCell"
        static let LoginItemCell = "LoginItemCell"
        static let UserHabitCell = "UserHabitCell"
        static let NewUserHabitNameCell = "NewUserHabitNameCell"
        static let NewUserHabitDescriptionsCell = "NewUserHabitDescriptionsCell"
        static let NewUserHabitTimeCell = "NewUserHabitTimeCell"
        static let NewUserHabitDayCell = "NewUserHabitDayCell"
        static let SearchedUserCell = "SearchedUserCell"
        static let FriendHabitCell = "FriendHabitCell"
    }
    
    struct Segues {
        static let ShowRegistration =  "ShowRegistration"
        static let ShowUserProfile =  "ShowUserProfile"
        static let ShowUserHabit =  "ShowUserHabit"
        static let ShowSearch =  "ShowSearch"
        static let ShowMessagingPopUp =  "ShowMessagingPopUp"
    }
    
    struct Images {
        static let DefaultProfileImage: UIImage = #imageLiteral(resourceName: "default_profile_image")
        static let Warning: UIImage = #imageLiteral(resourceName: "warning")
        static let Notification: UIImage = #imageLiteral(resourceName: "noti")
        static let Health: UIImage = #imageLiteral(resourceName: "health")
        static let Today: UIImage = #imageLiteral(resourceName: "today")
    }
    
    struct Strings {
        static let DefaultHabitTime = "12:00"
    }
    
    struct Times {
        static let MessagePopUpAnimation: Double = 0.4
    }
}
