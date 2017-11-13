//
//  PMCheckBox.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 13..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import M13Checkbox

class PMCheckBox: M13Checkbox {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.boxType = .square
        self.markType = .checkmark
        self.stateChangeAnimation = .stroke
        self.hideBox = true
        self.secondaryTintColor = UIColor.clear
        self.secondaryCheckmarkTintColor = UIColor(rgb: 0x00ab00)
        self.tintColor = UIColor(rgb: 0x00ab00)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor(rgb: 0x00ab00).cgColor
        self.layer.borderWidth = 1.0
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.cornerRadius = self.frame.size.height/2
    }
    
}
