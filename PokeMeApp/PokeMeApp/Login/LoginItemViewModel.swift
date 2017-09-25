//
//  LoginItemViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class LoginItemViewModel: NSObject {
    
    var model: LoginItem = LoginItem() {
        didSet {
            self.key.value = model.key
        }
    }

    var key: Variable<String> = Variable("")
    
}
