//
//  NewUserHabitSection.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct NewUserHabitSection {
    var header: String
    var items: [UserHabitWrapper]
    
}

extension NewUserHabitSection : SectionModelType {
    
    init(original: NewUserHabitSection, items: [UserHabitWrapper]) {
        self = original
        self.items = items
    }
    
    
    var identity: String {
        return header
    }
}
