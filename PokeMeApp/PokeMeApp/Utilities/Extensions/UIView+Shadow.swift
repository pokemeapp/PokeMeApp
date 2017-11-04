//
//  UIView+Shadow.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(color: UIColor = .black, radius: CGFloat = 1.0, opacity: Float = 1.0, offset: CGSize = CGSize(width: 1.0, height: 1.0)){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
}

