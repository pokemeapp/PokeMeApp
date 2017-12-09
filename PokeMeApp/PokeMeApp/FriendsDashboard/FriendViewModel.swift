//
//  FriendHabitViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SDWebImage
import PokeMeKit

class FriendViewModel: NSObject {

    var model: PMUser! {
        didSet {
            self.name.value = "\(model.firstname) \(model.lastname)"
            
        }
    }
    
    var name: Variable<String> = Variable("")
    
}
