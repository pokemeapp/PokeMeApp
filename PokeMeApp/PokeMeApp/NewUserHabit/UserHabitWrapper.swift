//
//  UserHabitWrapper.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 05..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

enum UserHabitCellType{
    case name
    case description
    case day
    case time
}

struct UserHabitWrapper {
    var name: String?
    var days: [UserHabitDay]?
    var type: UserHabitCellType?
}
