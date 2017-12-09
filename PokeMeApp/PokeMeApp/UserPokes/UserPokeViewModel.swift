//
//  UserPokeViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class UserPokeViewModel: NSObject {
    
    var model: PMPokePrototype? {
        didSet {
            guard let model = model else {
                return
            }
            self.name.value = model.name
            self.message.value = model.message
        }
    }

    var name = Variable("")
    var message = Variable("")
}
