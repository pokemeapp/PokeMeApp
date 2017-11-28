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
            self.value.asObservable().bind { value in
                self.model.value = value
            }.disposed(by: rx.disposeBag)
        }
    }

    var key: Variable<String> = Variable("")
    var value: Variable<String> = Variable("")
}
