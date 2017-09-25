//
//  CYTranslatedButton.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class CYTranslatedButton: UIButton {
    
    @IBInspectable var translationKey: String = "" {
        didSet {
            self.setTitle(translationKey.localized, for: .normal)
        }
    }

}
