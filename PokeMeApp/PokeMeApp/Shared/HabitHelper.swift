//
//  HabitHelper.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 13..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class HabitHelper {

    static var shared = HabitHelper()
    
    func convertImage(from type: String?) -> UIImage{
        guard let type = type else {
            return UIImage()
        }
        switch type {
        case "health":
            return #imageLiteral(resourceName: "health")
        case "warning":
            return #imageLiteral(resourceName: "warning")
        case "notification":
            return#imageLiteral(resourceName: "noti")
        case "calendar":
            return #imageLiteral(resourceName: "today")
        default:
            return UIImage()
        }
    }
    
    func convertType(from image: UIImage) -> String?{
        switch image {
        case Constants.Images.Health:
            return "health"
        case Constants.Images.Today:
            return "calendar"
        case Constants.Images.Notification:
            return "notification"
        case Constants.Images.Warning:
            return "warning"
        default:
            return nil
        }
    }
    
}
