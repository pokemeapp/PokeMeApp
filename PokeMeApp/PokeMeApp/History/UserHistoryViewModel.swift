//
//  UserHistoryViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class UserHistoryViewModel: NSObject {

    var model: PMPoke? {
        didSet {
            guard let model = model else {
                return
            }
            message.value = model.prototype!.message
        }
    }
    
    var message = Variable("")
    
}
