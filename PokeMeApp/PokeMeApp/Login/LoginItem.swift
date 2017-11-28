//
//  LoginItem.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class LoginItem: NSObject {
    
    var key: String = ""
    var value: String = ""
    
    init(key: String = "") {
        self.key = key
        super.init()
    }
    
}
