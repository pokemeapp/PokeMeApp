//
//  RegistrationItem.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class RegistrationItem: NSObject {
    
    var key: String = ""
    
    init(key: String) {
        self.key = key
        super.init()
    }
    
    override init() {
        super.init()
    }

}
