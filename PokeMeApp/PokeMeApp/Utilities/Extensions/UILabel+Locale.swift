//
//  UILabel+Locale.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

class CYTranslatedLabel : UILabel {
    
    @IBInspectable var translationKey: String = "" {
        didSet {
            self.text = translationKey.localized
        }
    }
    
}
