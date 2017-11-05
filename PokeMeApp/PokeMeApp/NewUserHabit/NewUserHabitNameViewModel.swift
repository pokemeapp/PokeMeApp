//
//  NewUserHabitNameViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewUserHabitNameViewModel: NSObject {
    
    var model: String = "" {
        didSet {
            self.name.value = model
        }
    }

    var name: Variable<String> = Variable("")
}
