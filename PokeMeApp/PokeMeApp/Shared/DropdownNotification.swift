//
//  DropdownNotification.swift
//  weedmagnet-ios
//
//  Created by Zsolt Pete on 2017. 10. 18..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class DropdownNotification: NSObject {

    var message: String
    
    init(message: String, url: String? = nil) {
        self.message = message
        super.init()
    }
    
}
