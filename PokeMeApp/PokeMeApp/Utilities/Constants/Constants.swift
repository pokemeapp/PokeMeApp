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
    }
    
    struct Segues {
        static let ShowRegistration =  "ShowRegistration"
        static let ShowUserProfile =  "ShowUserProfile"
        static let ShowUserHabit =  "ShowUserHabit"
    }
    
    struct Images {
        static let DefaultProfileImage: UIImage = #imageLiteral(resourceName: "default_profile_image")
    }
    
    struct Strings {
        static let DefaultHabitTime = "12:00"
    }
}
