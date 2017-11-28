//
//  RegistrationItemViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegistrationItemViewModel: NSObject {
    
    var model: RegistrationItem = RegistrationItem(){
        didSet {
            self.key.value = model.key
            self.value.asObservable().bind() { value in
                self.model.value = value
            }.disposed(by: rx.disposeBag)
        }
    }
    
    var key: Variable<String> = Variable("")
    var value: Variable<String> = Variable("")
}
