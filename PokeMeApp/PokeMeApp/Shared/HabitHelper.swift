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
    
    func convertImage(from type: HabitType?) -> UIImage{
        guard let type = type else {
            return UIImage()
        }
        switch type {
        case .health:
            return #imageLiteral(resourceName: "health")
        case .warning:
            return #imageLiteral(resourceName: "warning")
        case .notification:
            return#imageLiteral(resourceName: "noti")
        case .today:
            return #imageLiteral(resourceName: "today")
        }
    }
    
    func convertType(from image: UIImage) -> HabitType?{
        switch image {
        case Constants.Images.Health:
            return .health
        case Constants.Images.Today:
            return .today
        case Constants.Images.Notification:
            return .notification
        case Constants.Images.Warning:
            return .warning
        default:
            return nil
        }
    }
    
}
