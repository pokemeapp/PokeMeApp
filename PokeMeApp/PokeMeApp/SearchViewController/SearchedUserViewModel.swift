//
//  SearchedUserViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 14..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import PokeMeKit

class SearchedUserViewModel: NSObject {
    
    var model: PMUser?{
        didSet {
            guard let model = model else {
                return
            }
            self.name.value = model.firstname + " " + model.lastname
        }
    }
    
    var name: Variable<String> = Variable("")

}
