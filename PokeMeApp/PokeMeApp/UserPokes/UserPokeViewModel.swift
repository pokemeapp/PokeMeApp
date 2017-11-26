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

class UserPokeViewModel: NSObject {
    
    var model: UserPoke? {
        didSet {
            guard let model = model else {
                return
            }
            self.name.value = model.name!
        }
    }

    var name = Variable("")
}
