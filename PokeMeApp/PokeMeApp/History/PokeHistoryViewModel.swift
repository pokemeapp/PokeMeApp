//
//  PokeHistoryViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 12. 10..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import PokeMeKit
import RxSwift
import RxCocoa

class PokeHistoryViewModel: NSObject {

    var model: PMPokePrototype? {
        didSet {
            guard let model = model else {
                return
            }
            self.name.value = model.name
        }
    }
    
    var name = Variable("")
    
}
