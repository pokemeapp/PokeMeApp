//
//  Date+ToHourMinute.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 11..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation

extension Date {
    
    func toHourMinute() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let string = formatter.string(from: self)
        return string
    }
    
}
