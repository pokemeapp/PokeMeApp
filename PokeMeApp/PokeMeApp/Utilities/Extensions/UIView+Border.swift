//
//  UIView+Border.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorder(color: UIColor = .black, width: CGFloat = 1.0){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}
