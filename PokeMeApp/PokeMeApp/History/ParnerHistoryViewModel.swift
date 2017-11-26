//
//  ParnerHistoryViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ParnerHistoryViewModel: NSObject {

    var model: History? {
        didSet {
            guard let model = model else {
                return
            }
            message.value = model.message!
        }
    }
    
    var message = Variable("")
    
}
